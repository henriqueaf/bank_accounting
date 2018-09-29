require 'rails_helper'

RSpec.describe UseCases::TransferMoney do
  let(:source_account) { create(:user).account }
  let(:destination_account) { create(:user).account }
  let(:transfer_value) { 20 }

  subject {
    UseCases::TransferMoney.new(
      source_account_id: source_account.id,
      destination_account_id: destination_account.id,
      value: transfer_value
    )
  }

  context "Responds" do
    it { should respond_to(:transfer?) }
  end

  it "should be a class" do
    expect(UseCases::TransferMoney).to be_a(Class)
  end

  context "source account without enough money" do
    before do
      source_account.transferences.update_all(value: 0.0)
    end

    it "should return false" do
      result = subject.transfer?
      source_account_transference = source_account.transferences.find_by(value: -transfer_value)
      destination_account_transference = destination_account.transferences.find_by(value: transfer_value)

      expect(result).to be_falsey
      expect(source_account_transference).to be_nil
      expect(destination_account_transference).to be_nil
    end
  end

  context "source account with enough money" do
    before do
      source_account.transferences.update_all(value: transfer_value)
    end

    it "should return true" do
      result = subject.transfer?
      source_account_transference = source_account.transferences.find_by(value: -transfer_value)
      destination_account_transference = destination_account.transferences.find_by(value: transfer_value)

      expect(result).to be_truthy
      expect(source_account_transference).not_to be_nil
      expect(destination_account_transference).not_to be_nil
    end

    context "raise error on database transaction" do
      it "should not create transferences" do
        allow(Transference).to receive(:create!).and_raise("boom")
        expect{ subject.transfer? }.to raise_error("boom")

        source_account_transference = source_account.transferences.find_by(value: -transfer_value)
        destination_account_transference = destination_account.transferences.find_by(value: transfer_value)

        expect(source_account_transference).to be_nil
        expect(destination_account_transference).to be_nil
      end
    end

    context "source_account not exist" do
      it "should raise error" do
        expect{
          UseCases::TransferMoney.new(
            source_account_id: 999,
            destination_account_id: 999,
            value: transfer_value
          ).transfer?
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
