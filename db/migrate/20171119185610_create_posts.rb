class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :text
      t.integer :number_of_likes
      t.string :poster_name
      t.integer :poster_id
      t.integer :wall_id
      t.integer :parent_id

      t.timestamps
    end
  end
end