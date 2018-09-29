require 'rails_helper'

RSpec.describe User, type: :model do
  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
  end

  context "Validations" do
    it { should_not allow_value("", nil).for(:name) }
    it { should validate_presence_of(:name) }
  end

  context "Associations" do
    it { should have_one(:account) }
  end

  context "Callback" do
    context "after_create#create_initial_transference" do
      it "should create an initial transference after create" do
        user = create(:user)
        expect(user.transferences.sum(:value)).to eq(Transference::INITIAL_VALUE)
      end
    end
  end
end
