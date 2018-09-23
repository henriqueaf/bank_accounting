require 'rails_helper'

RSpec.describe UseCases::GetBalance do
  subject { UseCases::GetBalance }

  context "Responds" do
    it { should respond_to(:get_balance) }
    it { should be_a(Class) }
  end

  context "Methods" do
    context "@get_balance" do
      context "without existing account" do
        it "should return account not found" do
          expect( subject.get_balance(account_id: "invalid") ).to eq("Account not found")
        end
      end

      context "with existing account" do
        let(:account) { create(:user).account }

        it "should return account balance" do
          account_amount = account.transferences.sum(:value)
          expect( subject.get_balance(account_id: account.id) ).to eq(account_amount)
        end
      end
    end
  end
end
