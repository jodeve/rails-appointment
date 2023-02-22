# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "admin@gmail.com", password: "password")

def create_schedule day, i
  Schedule.create(
    day: day,
    start: i,
    close: i + 1
  )
end

Date::DAYNAMES.each do |day|
  if day != "Sunday" && day != "Saturday"
    (8..16).each do |i|
      create_schedule day, i
    end
  end
end

(8..11).each do |i|
  create_schedule "Saturday", i
end
