class Property < ApplicationRecord
  # Os possiveis status de uma Propriedades
  enum status: [ :active, :pending, :inactive, :blocked ]
  # Os tipos de acomodação: casa inteira, quarto inteiro e quarto compartilhado
  enum accommodation_type: [ :whole_house, :whole_bedroom, :shared_bedroom ]


  belongs_to :user
  belongs_to :address
  belongs_to :facility

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :facility

  has_many :wishlists
  has_many :photos
  has_many :reservations

  has_many :talks
  has_many :messages

  # Associa aos comentários
  has_many :comments
  searchkick

  # Força a ter esses campos preenchidos para criar um Property
  validates_presence_of :address, :facility, :user, :status, :price,
                        :accommodation_type, :beds, :bedroom, :bathroom, :guest_max,
                        :description

  def search_data
    {
      name: name,
      status: status,
      address_country: address.country,
      address_city: address.city,
      address_state: address.state,
      address_neighborhood: address.neighborhood,
      wifi: facility.wifi,
      washing_machine: facility.washing_machine,
      clothes_iron: facility.clothes_iron,
      towels: facility.towels,
      air_conditioning: facility.air_conditioning,
      refrigerato: facility.refrigerator,
      heater: facility.heater
    }
  end

  def get_rating
    self.rating.round
  end

  def is_available? checkin_date, checkout_date
    self.reservations.where(status: [:pending, :active]).each do |reservation|
      if reservation.checkin_date.between?(checkin_date, checkout_date) or
         reservation.checkout_date.between?(checkin_date, checkout_date) or
         checkin_date.between?(reservation.checkin_date, reservation.checkout_date) or
         checkout_date.between?(reservation.checkin_date, reservation.checkout_date)
        return false
      end
    end
  true
  end
end

  class String
     def to_b
     if self == "false"
        false
     else
       true
     end
  end
end
