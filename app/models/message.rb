class Message < ApplicationRecord
  belongs_to :talk
  belongs_to :user

  validates_presence_of :talk, :body, :user
end
