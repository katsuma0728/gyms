FactoryBot.define do
  factory :schedule do
    title { Faker::Lorem.characters(number: 10) }
    memo { Faker::Lorem.characters(number: 30) }
    start_time { Time.now }
  end
end
