require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
  end
end
