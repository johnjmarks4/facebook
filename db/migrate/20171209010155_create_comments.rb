class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :likes
      t.string :poster_name
      t.belongs_to :user, foreign_key: true
      t.integer :parent_id

      t.timestamps
    end
  end
end
