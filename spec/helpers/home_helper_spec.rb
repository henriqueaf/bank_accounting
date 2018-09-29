require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe "#display_amount" do
    it "should return account amount on div" do
      amount = Faker::Number.decimal(10,2).to_d
      expect( helper.display_amount(amount) ).to include("h1", "text-success", number_to_currency(amount))
    end
  end

  describe "#display_transference_list_item" do
    let!(:account){ create(:account) }

    context "with positive value" do
      context "with multiple transferences" do
        let!(:first_timestamp){ Time.parse("2018-04-01").beginning_of_day }
        let!(:second_timestamp){ Time.parse("2018-04-02").beginning_of_day }

        it "should return transference value on a li with text-success class" do
          first_transference = create(:transference, account: account, created_at: first_timestamp)
          second_transference = create(:transference, account: account, created_at: second_timestamp)

          result = helper.display_transference_list_item(second_transference)
          expect( result ).to include("li", "text-success", number_to_currency(second_transference.value))
          expect( result ).to include(
            number_to_currency(
              UseCases::GetBalance.get_balance_up_to_timestamp(account_id: account.id, timestamp: second_transference.created_at)
            )
          )
        end
      end
    end

    context "with negative value" do
      it "should return transference value on a li with text-danger class" do
        transference = create(:transference, value: -10)
        expect( helper.display_transference_list_item(transference) ).to include("li", "text-danger", number_to_currency(transference.value))
      end
    end
  end
end
