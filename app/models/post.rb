class Post < ApplicationRecord
  validates :text, length: { maximum: 1000 }, presence: true
  belongs_to :poster, :class_name => "User"
  belongs_to :wall, :class_name => "User"
  has_many :comments, :dependent => :destroy, :foreign_key => "parent_id"

  def self.users_posts(user_id)
    Post.where(poster_id: user_id).order(created_at: :desc)
  end

  def self.wall_posts(user_id)
    Post.where(wall_id: user_id).order(created_at: :desc)
  end

  def self.friends_posts(user_id)
    posts = []

    ids = Friendship.select("id, user_id").where(friend_id: user_id).or(Friendship.select("id, user_id").where(user_id: user_id))

    ids.each do |relation|
      Post.where(poster_id: relation[:user_id]).each do |post|
        unless post.poster_id == user_id.to_i && post.parent_id.nil?
          posts << post
        end
      end
    end

    posts.sort_by { |post| post[:created_at] }.reverse
  end
end