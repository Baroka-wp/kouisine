# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "samia",
             email: "samia@gmail.com",
             password: "test66",
             password_confirmation: "test66")

User.create(name: "Fania",
            email: "fania@gmail.com",
            password: "test66",
            password_confirmation: "test66")
User.create(name: "bijou",
            email: "bijou@gmail.com",
            password: "test66",
            password_confirmation: "test66")


10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "test66"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end
