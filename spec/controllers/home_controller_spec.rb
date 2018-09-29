require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user){ create(:user) }

  context "unsigned user" do
    expect_redirected_after

    it "should redirect" do
      get :index
    end
    it "should redirect" do
      get :transference_form
    end
    it "should redirect" do
      post :transfer_money
    end
  end

  context "signed in user" do
    before do
      sign_in_mock_user(user)
    end

    describe "GET #index" do
      it "returns http success and assigns" do
        get :index

        account_balance = Core.get_balance(user.account.id)

        expect(response).to have_http_status(:success)
        expect(assigns(:account_balance)).to eq(account_balance)
        expect(assigns(:transferences)).to eq(user.account.transferences)
      end
    end

    describe "GET #transference_form" do
      it "returns http success" do
        get :transference_form
        expect(response).to have_http_status(:success)
        expect(response).to render_template("_transference_form")
      end
    end

    describe "POST #transfer_money" do
      let(:source_account){ create(:account) }
      let(:destination_account){ create(:account) }
      let(:low_value){ Faker::Number.decimal(3,2) }
      let(:high_value){ Faker::Number.decimal(5,2) }

      context "with valid attributes" do
        it "should return http success" do
          source_account.transferences.create(value: high_value)

          post :transfer_money, params: {
            transfer_money: {
              destination_account_id: destination_account.id,
              value: low_value
            }
          }

          expect(response).to have_http_status(200)
        end
      end

      context "with invalid attributes" do
        it "should return http 400" do
          source_account.transferences.create(value: low_value)

          post :transfer_money, params: {
            transfer_money: {
              destination_account_id: destination_account.id,
              value: high_value
            }
          }

          expect(response).to have_http_status(400)
        end
      end
    end
  end
end
