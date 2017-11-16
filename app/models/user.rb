class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :friendships       
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"      
  has_many :invers_friends, :through => :inverse_friendships, :source => :user
  has_many :posts
  has_many :comments, :through => :posts
  has_many :wall_posts
  has_many :pictures

  def self.users_matching_name(name)
    first_name = name.split(" ")[0]
    last_name = name.split(" ")[1]
    User.where(['first_name = ? AND last_name = ?', first_name, last_name]).all
  end

  def self.users_friends(user) #fix
    friends = []
    user.friendships.each do |friendship|
      friends << friendship.friend_id
    end
    friends
  end
end