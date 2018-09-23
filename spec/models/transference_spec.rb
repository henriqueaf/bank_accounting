require 'rails_helper'

RSpec.describe Transference, type: :model do
  it "Should have a valid factory" do
    expect(FactoryBot.build(:transference)).to be_valid
  end

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

  context "Class Methods" do
    context "#transfer_money?" do
      let(:source_account) { create(:user).account }
      let(:destination_account) { create(:user).account }
      let(:transfer_value) { Faker::Number.decimal(10, 2).to_f }

      context "source account without enough money" do
        before do
          source_account.transferences.update_all(value: 0.0)
        end

        it "should return false" do
          result = Transference.transfer_money?(source_account.id, destination_account.id, transfer_value)
          source_account_transference = source_account.transferences.find_by(value: -transfer_value)
          destination_account_transference = destination_account.transferences.find_by(value: transfer_value)

          expect(result).to be_falsey
          expect(source_account_transference).to be_nil
          expect(destination_account_transference).to be_nil
        end
      end

      context "with enough money" do
        before do
          source_account.transferences.update_all(value: transfer_value)
        end

        it "should return true" do
          result = Transference.transfer_money?(source_account.id, destination_account.id, transfer_value)
          source_account_transference = source_account.transferences.find_by(value: -transfer_value)
          destination_account_transference = destination_account.transferences.find_by(value: transfer_value)

          expect(result).to be_truthy
          expect(source_account_transference).not_to be_nil
          expect(destination_account_transference).not_to be_nil
        end

        context "raise error on database transaction" do
          it "should not create transferences" do
            allow(Transference).to receive(:create!).and_raise("boom")
            expect{ Transference.transfer_money?(source_account.id, destination_account.id, transfer_value) }.to raise_error("boom")

            source_account_transference = source_account.transferences.find_by(value: -transfer_value)
            destination_account_transference = destination_account.transferences.find_by(value: transfer_value)

            expect(source_account_transference).to be_nil
            expect(destination_account_transference).to be_nil
          end
        end
      end
    end
  end
end
