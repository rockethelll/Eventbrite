# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Event.destroy_all
Attendance.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('attendances')
ActiveRecord::Base.connection.reset_pk_sequence!('events')

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

Attendance.create(event_id: 1, user_id: 1, stripe_customer_id: "123123")
Attendance.create(event_id: 2, user_id: 1, stripe_customer_id: "456456")
Attendance.create(event_id: 3, user_id: 1, stripe_customer_id: "789789")
