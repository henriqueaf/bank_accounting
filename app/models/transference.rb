class Transference < ApplicationRecord
  INITIAL_VALUE = 5000

  belongs_to :account

  validates :account, presence: true
  validates :value, presence: true, numericality: { other_than: 0 }

  def self.transfer_money?(source_account_id, destination_account_id, transference_value)
    return false unless Account.exists?(id: source_account_id) || Account.exists?(id: destination_account_id)

    source_account = Account.find(source_account_id)
    return false if source_account.amount < transference_value

    ActiveRecord::Base.transaction do
      Transference.create!(account_id: source_account_id, value: -(transference_value))
      Transference.create!(account_id: destination_account_id, value: transference_value)
    end
  end
end
