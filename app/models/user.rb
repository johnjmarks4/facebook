class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :friendships       
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"      
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :posts
  has_many :comments, :through => :posts
  has_many :wall_posts
  has_many :pictures

  def self.users_matching_name(name)
    first_name = name.split(" ")[0]
    last_name = name.split(" ")[1]
    User.where(['first_name = ? AND last_name = ?', first_name, last_name]).all
  end

  def self.users_friends(user)
    friends = []
    user.friendships.each do |friendship|
      friends << friendship.friend_id
    end
    friends
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      name = auth.info.name   # assuming the user model has a name
      user.first_name = name.split(" ")[0]
      user.last_name = name.split(" ")[1]
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end