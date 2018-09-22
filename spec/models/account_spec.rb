require 'rails_helper'

RSpec.describe Account, type: :model do
  it "should have a valid factory" do
    expect(FactoryBot.build(:account)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:user_id) }
    it { should respond_to(:identifier) }
  end

  context "Validations" do
    it { should validate_presence_of(:user) }
    it { should_not allow_value("", nil).for(:identifier) }
    it { should validate_length_of(:identifier).is_equal_to(6) }

    describe "#generate_identifier" do
      it "should generate identifier before create" do
        account = build(:account)
        previous_identifier = account.identifier
        expect(account).to receive(:generate_identifier).and_call_original
        account.save
        expect(account.identifier).not_to eq(previous_identifier)
      end
    end
  end

  context "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:transferences) }
  end
end