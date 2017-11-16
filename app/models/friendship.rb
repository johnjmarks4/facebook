class Friendship < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :user
  belongs_to :friend, :class_name => "User"
end
