FactoryBot.define do
  factory :subscription do
    title { Faker::Lorem.sentence }
    price { Faker::Commerce.price(range: 5.0..20.0) }
    status { ['subscribed', 'cancelled'].sample }
    frequency { ['daily', 'weekly', 'monthly'].sample }
    association :customer
    association :tea
  end
end
