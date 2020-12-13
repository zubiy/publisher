FactoryBot.define do
  factory :stock do
    book
    shop

    amount { Faker::Number.between(0, 100) }
  end
end
