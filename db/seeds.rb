# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Event.destroy_all

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email(domain: 'yopmail.com'),
    description: Faker::Lorem.paragraph,
    password: 123456
  )
end

20.times do
  Event.create!(
    start_date: Faker::Date.forward(days: 23),
    duration: 120,
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    price: rand(5..50),
    location: Faker::Address.city
  )
end
