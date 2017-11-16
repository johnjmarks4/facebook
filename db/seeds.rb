require 'faker'

User.create(first_name: Faker::Name.first_name, 
            last_name:  Faker::Name.last_name,
            email:      Faker::Internet.email)

User.new(:password => password).encrypted_password