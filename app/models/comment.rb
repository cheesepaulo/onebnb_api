class Comment < ApplicationRecord
  enum status: [ :active, :block ]
end
