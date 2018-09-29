require 'rails_helper'

RSpec.describe Transference, type: :model do
  context "Should Respond" do
    it { should respond_to(:account_id) }
    it { should respond_to(:value) }
  end

  context "Validations" do
    it { should validate_presence_of(:account) }
    it { should validate_presence_of(:value) }

    context "cannot have zero as value" do
      it "should be invalid when set zero as value" do
        transference = build(:transference, value: 0.0)
        expect(transference).to be_invalid
        expect(transference.errors.keys).to include(:value)
      end
    end
  end

  context "Associations" do
    it { should belong_to(:account) }
  end
end
