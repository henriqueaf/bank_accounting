class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, allow_blank: false

  has_one :account
  has_many :transferences, through: :account

  after_create :create_initial_transference

  private

  def create_initial_transference
    account = self.create_account
    account.transferences.create(value: Transference::INITIAL_VALUE)
  end
end
