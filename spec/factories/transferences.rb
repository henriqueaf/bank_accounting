FactoryBot.define do
  factory :transference do
    account
    value { Faker::Number.decimal(8, 2) }
  end
end
