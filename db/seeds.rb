require 'faker'

15.times do
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
wikis = Wiki.all

50.times do
  collaborator = Collaborator.create(
    user: users.sample,
    wiki: wikis.sample,
    )
end

admin = User.new(
  user_name: 'admin',
  email:     'admin@example.com',
  password:  'helloworld',
  role:      'admin'
)
admin.skip_confirmation!
admin.save

premium = User.new(
  user_name: 'premium',
  email:     'premium@example.com',
  password:  'helloworld',
  role:      'premium'
)
premium.skip_confirmation!
premium.save

member = User.new(
  user_name:     'member',
  email:    'member@example.com',
  password: 'helloworld',
)
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Collaborator.count} collaborators created"