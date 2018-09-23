class Transference < ApplicationRecord
  INITIAL_VALUE = 5000

  belongs_to :account

  validates :account, presence: true
  validates :value, presence: true, numericality: { other_than: 0 }
end
