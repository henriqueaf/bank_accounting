require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe "#display_amount" do
    it "should return account amount on div" do
      amount = Faker::Number.decimal(10,2).to_f
      expect( helper.display_amount(amount) ).to include("h1", "text-success", number_to_currency(amount))
    end
  end
end
