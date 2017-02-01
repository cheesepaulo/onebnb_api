class Comment < ApplicationRecord
  enum status: [ :active, :block ]
  belongs_to :user
  belongs_to :property
end
