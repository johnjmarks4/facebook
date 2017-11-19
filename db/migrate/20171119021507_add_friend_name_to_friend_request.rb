class AddFriendNameToFriendRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :friend_requests, :user_name, :string
  end
end
