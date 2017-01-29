class Reservation < ApplicationRecord
  enum status: [ :pending, :active, :finished, :paid, :canceled ]
end
