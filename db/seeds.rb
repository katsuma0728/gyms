# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: 'admin@example.com',
    password: "123456",
)

User.create!(
  [
    {email: 'tom@example.com', password: 'password', name: 'Tom', birth_date: '1995-01-01', sex: '男性', introduction: '筋肉量＋５キロ', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'mike@example.com', password: 'password', name: 'Mike', birth_date: '2000-02-22', sex: '男性', introduction: 'ベンチプレスMAX200キロ', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: 'emma@example.com', password: 'password', name: 'Emma', birth_date: '1990-03-30', sex: '女性', introduction: '夏までに―５キロ', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")}
  ]
)
