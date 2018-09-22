FactoryBot.define do
  factory :account do
    user
    identifier { SecureRandom.hex(3) }
  end
end
