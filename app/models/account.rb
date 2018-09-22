class Account < ApplicationRecord
  belongs_to :user
  has_many :transferences

  validates :user, presence: true
  validates :identifier, length: {is: 6}, allow_blank: false, presence: true, on: :update

  before_create :generate_identifier

  def amount
    self.transferences.sum(:value)
  end

  private

  def generate_identifier
    begin
      self.identifier = SecureRandom.hex(3)
    end while Account.exists?(identifier: self.identifier)
  end
end
