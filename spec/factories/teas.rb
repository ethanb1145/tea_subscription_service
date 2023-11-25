FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Lorem.paragraph }
    temperature { Faker::Number.between(from: 70, to: 100) }
    brew_time { Faker::Number.between(from: 2, to: 5) }
  end
end
