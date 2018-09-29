class UseCases::TransferMoney
  def initialize(source_account_id:, destination_account_id:, value:)
    @source_account_id = source_account_id
    @destination_account_id = destination_account_id
    @value = value
  end

  def transfer?
    source_account_balance = UseCases::GetBalance.get_balance(account_id: @source_account_id)
    return false if source_account_balance < @value

    transfer_result = ActiveRecord::Base.transaction do
      Transference.create!(account_id: @source_account_id,      value: - @value)
      Transference.create!(account_id: @destination_account_id, value: @value)
    end

    transfer_result.persisted?
  end
end
