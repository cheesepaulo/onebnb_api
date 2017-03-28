class Reservation < ApplicationRecord
  enum status: [ :pending, :active, :finished, :paid, :canceled , :refused]
  belongs_to :property
  belongs_to :user

  has_many :talks

  # Força a ter esses campos preenchidos para criar um Reservation
  validates_presence_of :property, :user

  before_create :set_pending_status

  def set_pending_status
    self.status ||= :pending
  end

  def interval_of_days
    (self.checkout_date - self.checkin_date).to_i
  end

  def evaluate comment, new_rating
    Reservation.transaction do
      property = self.property

      # Gera um Novo comentário
      Comment.create(property: property, body: comment, user: self.user)
      # Calcula a nova nota da Propriedade
      quantity        = property.reservations.where(evaluation: true).count
      property.rating = (((property.rating * quantity) + new_rating) / (quantity + 1))
      property.save!

      # Seta o evaluation como true
      self.evaluation = true
      self.save!
    end
  end
end
