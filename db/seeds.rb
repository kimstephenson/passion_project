require 'Faker'

User.destroy_all

10.times do
  user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email)
  user.password = "password"
  user.save
end
