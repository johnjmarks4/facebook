class Comment < ApplicationRecord
  belongs_to :post, :foreign_key => "parent_id"
  belongs_to :user
end
