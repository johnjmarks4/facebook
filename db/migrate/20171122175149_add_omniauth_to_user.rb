class AddOmniauthToUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :provider
    remove_column :users, :uid

    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
  end
end
