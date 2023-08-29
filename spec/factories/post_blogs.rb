FactoryBot.define do
  factory :post_blog do
    title { Faker::Lorem.characters(number: 10) }
    blog { Faker::Lorem.characters(number: 30) }
  end
end
