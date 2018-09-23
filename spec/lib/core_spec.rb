require 'rails_helper'

RSpec.describe Core do
  context "Responds" do
    it { should respond_to(:transfer_money?) }
    it { should respond_to(:get_balance) }
    it { should be_a(Module) }
  end

  context "Methods" do
    context "@transfer_money?" do
      let(:source_account_id){ 1 }
      let(:destination_account_id){ 2 }
      let(:value){ 100 }

      it "should build a new UseCases::TransferMoney object" do
        expect(UseCases::TransferMoney).to receive(:new).with(
          source_account_id: source_account_id,
          destination_account_id: destination_account_id,
          value: value
        ).and_call_original

        Core.transfer_money?(source_account_id, destination_account_id, value)
      end

      it "should call UseCases::TransferMoney.transfer method" do
        expect_any_instance_of(UseCases::TransferMoney).to receive(:transfer?)
        Core.transfer_money?(source_account_id, destination_account_id, value)
      end
    end
  end

  context "Methods" do
    context "@get_balance" do
      let(:account_id){ 1 }

      it "should call UseCases::GetBalance get_balance" do
        expect(UseCases::GetBalance).to receive(:get_balance).with(
          account_id: account_id
        ).and_call_original

        Core.get_balance(account_id)
      end
    end
  end
end
