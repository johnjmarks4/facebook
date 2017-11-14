class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.references :post
      t.references :friend
      t.references :wall_post
      t.references :picture
      t.references :comment

      t.timestamps
    end
  end
end