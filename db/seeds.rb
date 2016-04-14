# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..1000000
  user = User.create!(
    email: "#{i}@email.com",
    name: Faker::Name.name,
    password: 'password'
  )
  p "#{i}: #{user.name}"
end
