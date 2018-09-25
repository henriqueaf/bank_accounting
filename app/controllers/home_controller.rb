class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :format_value, only: :transfer_money

  def index
    @account_balance = Core.get_balance(current_user.account.id)
    @transferences = current_user.account.transferences
  end

  def transference_form
    users_and_account_ids = User
      .joins(:account)
      .where
      .not(id: current_user.id)
      .order("users.name")
      .pluck("users.name", "accounts.id")

    render partial: "transference_form", locals: {
      source_account_id: params[:source_account_id],
      dropdown_content: users_and_account_ids
    }
  end

  def transfer_money
    did_work = Core.transfer_money?(
      transfer_money_params[:source_account_id],
      transfer_money_params[:destination_account_id],
      transfer_money_params[:value].to_f
    )

    head (did_work ? 200 : 400)
  end

  private

  def transfer_money_params
    params.require(:transfer_money).permit(:source_account_id, :destination_account_id, :value)
  end

  def format_value
    params[:transfer_money][:value] = params[:transfer_money][:value].gsub(/[\.\,]/, "").insert(-3, ".")
  end
end
