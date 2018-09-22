class Transference < ApplicationRecord
  belongs_to :account

  validates :account, presence: true
  validates :value, presence: true, numericality: { other_than: 0 }
end
