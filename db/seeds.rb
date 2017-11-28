require 'faker'

me = User.create(first_name: "John", last_name: "Marks", email: "johnjmarks4@gmail.com", password: "password")

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

# First and second users are friends
Friendship.create(friend_id: User.first.id, user_id: User.take(2)[1].id)
Friendship.create(friend_id: User.take(2)[1].id, user_id: User.first.id)

# First and last users are friends
Friendship.create(friend_id: User.first.id, user_id: User.last.id)
Friendship.create(friend_id: User.last.id, user_id: User.first.id)


my_friends = me.friends.take

my_friends.posts.create(text: "This is a post!", created_at: "2017-11-27 18:21:14")
my_friends.posts.create(text: "Another post!", created_at: "2002-05-24 21:15:07")
my_friends.posts.create(text: "Third post!", created_at: "2017-11-27 18:21:13")
my_friends.posts.create(text: "Fourth post!", created_at: "2011-01-01 06:29:00")