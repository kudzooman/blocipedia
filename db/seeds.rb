require 'faker'

25.times do
  user = User.new(
    user_name:     Faker::Name.first_name,
    email:    Faker::Internet.email,
    password: "helloworld"
  )
  user.skip_confirmation!
  user.save
end
users = User.all

50.times do
  Wiki.create(
    user: users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )
end

member = User.new(
  user_name:     'HannahTall',
  email:    'hannahtall@yahoo.com',
  password: 'helloworld',
)
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"