require 'rails_helper'

RSpec.describe UseCases::GetBalance do
  subject { UseCases::GetBalance }

  context "Responds" do
    it { should respond_to(:get_balance) }
  end

  context "Methods" do
    context "@get_balance" do
      context "without existing account" do
        it "should return account not found" do
          expect{subject.get_balance(account_id: "invalid")}.to raise_error(ActiveRecord::RecordNotFound)
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

    context "@get_balance_up_to_timestamp(account_id, timestamp)" do
      let(:account){ create(:account) }

      context "with none transferences" do
        it "should return zero" do
          result = subject.get_balance_up_to_timestamp(
            account_id: account.id,
            timestamp: Faker::Date.forward(1)
          )
          expect(result).to eq(0)
        end
      end

      context "with transferences" do
        let!(:first_timestamp){ Time.parse("2018-04-01").beginning_of_day }
        let!(:second_timestamp){ Time.parse("2018-04-02").beginning_of_day }
        let!(:yesterday_transference){ create(:transference, account_id: account.id, created_at: first_timestamp, value: 10) }
        let!(:tomorrow_transference){ create(:transference, account_id: account.id, created_at: second_timestamp, value: 20) }

        context "passing yesterday timestamp" do
          it "should return only yesterday value" do
            result = subject.get_balance_up_to_timestamp(
              account_id: account.id,
              timestamp: first_timestamp.end_of_day
            )
            expect(result).to eq( yesterday_transference.value )
          end
        end

        context "passing tomorrow timestamp" do
          it "should return yesterday value and tomorrow value" do
            result = subject.get_balance_up_to_timestamp(
              account_id: account.id,
              timestamp: second_timestamp.end_of_day
            )
            expect(result).to eq( yesterday_transference.value + tomorrow_transference.value )
          end
        end
      end
    end
  end
end
