class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Add Omniauth support for Facebook
  devise :omniauthable, omniauth_providers: %i[facebook]

  # Associations
  has_many :posts, :dependent => :destroy, :foreign_key => :poster_id
  has_many :wall_posts, :dependent => :destroy, :class_name => "Post", :foreign_key => :wall_id
  
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  has_many :friend_requests, :dependent => :destroy
  has_many :friendships#, :dependent => :destroy       
  has_many :friends, :through => :friendships#, :dependent => :destroy

  has_many :inverse_friendships, :class_name => "Friendship"#, :foreign_key => "friend_id"#, :dependent => :destroy       
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user#, :dependent => :destroy

  # Validations
  validates :first_name, presence: true, length: { maximum: 12 }
  validates :last_name, presence: true, length: { maximum: 12 }

  validates :email, presence: true
  validates_uniqueness_of    :email,     :case_sensitive => false, :allow_blank => false, :if => :email_changed?
  validates_format_of    :email,    :with  => Devise.email_regexp, :allow_blank => false, :if => :email_changed?

  # Comment out these two lines to create users from the Rails Console
  validates_presence_of    :password, :on=>:create
  validates_confirmation_of    :password, :on=>:create

  # Set 'allow_blank' to true to create users from the Rails Console
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true

  def self.find_user_named(name)
    first_name = name.split(" ")[0]
    last_name = name.split(" ")[1]
    User.where(['first_name = ? AND last_name = ?', first_name, last_name]).all
  end

  def self.find_name(id)
    user = User.find(id)
    "#{user.first_name} #{user.last_name}"
  end

  def self.find_friends(user)
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
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
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

    User.find_by(email: user.email, first_name: user.first_name, last_name: user.last_name)
  end
end