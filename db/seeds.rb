require 'faker'

20.times do
  User.create(first_name:            Faker::Name.first_name, 
              last_name:             Faker::Name.last_name, 
              email:                 Faker::Internet.email, 
              password:              "password", 
              password_confirmation: "password")
end

ids = []
i = -1

User.all.each do |user|
  ids << user.id
end

ids.shuffle.each do |id|
  Friendship.create(friend_id: id, user_id: ids[i])
  i -= 1
end