class Property < ApplicationRecord
  # Os possíveis status de uma Propriedades
  enum status: [ :active, :pending, :inactive, :blocked ]
  # Os tipos de acomodação: casa inteira, quarto inteiro e quarto compartilhado
  enum accommodation_type: [ :whole_house, :whole_bedroom, :shared_bedroom ]

  belongs_to :user
  belongs_to :address
  belongs_to :facility
  has_many :wishlists
  has_many :photos
  searchkick

  validates_presence_of :user

  def search_data
    {
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
    refrigerator: facility.refrigerator,
    heater: facility.heater
    }
  end
end
