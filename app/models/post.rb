class Post < ApplicationRecord
  validates :text, length: { maximum: 1000 }, presence: true
  belongs_to :user
  has_many :comments

  def self.users_posts(user_id)
    Post.where(user_id: user_id).order(created_at: :desc)
  end

  def self.friends_posts(user_id)
    posts = []

    ids = Friendship.select("id, user_id").where(friend_id: user_id)

    ids.each do |relation|
      Post.where(user_id: relation[:user_id]).each do |post|
        posts << post
      end
    end

    posts.sort_by { |post| post[:created_at] }.reverse
  end
end