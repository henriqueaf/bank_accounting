require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe "#display_amount" do
    it "should return account amount on div" do
      amount = Faker::Number.decimal(10,2).to_f
      expect( helper.display_amount(amount) ).to include("h1", "text-success", number_to_currency(amount))
    end
  end

  describe "#display_transference_list_item" do
    context "with positive value" do
      it "should return transference value on a li with text-success class" do
        transference = build_stubbed(:transference)
        expect( helper.display_transference_list_item(transference) ).to include("li", "text-success", number_to_currency(transference.value))
      end
    end

    context "with negative value" do
      it "should return transference value on a li with text-danger class" do
        transference = build_stubbed(:transference, value: -10)
        expect( helper.display_transference_list_item(transference) ).to include("li", "text-danger", number_to_currency(transference.value))
      end
    end
  end
end
