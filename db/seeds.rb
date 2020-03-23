# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Course.destroy_all

User.create!(email: "admin@gmail.com", admin: true, password: "nyuszkalacs")

i = 0

5.times do 
	Course.create!(name: "Intro to Programming #{i}", description: "A brief introduction to programming for employees who are not familiar.", start_date: Date.today + 1, end_date: Date.today + 30, time: "MW 2-3pm")
	i += 1
end