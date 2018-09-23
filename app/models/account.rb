class Account < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :identifier, length: {is: 6}, allow_blank: false, presence: true

  before_create :generate_identifier

  private

  def generate_identifier
    begin
      self.identifier = SecureRandom.hex(3)
    end while Account.exists?(identifier: self.identifier)
  end
end
