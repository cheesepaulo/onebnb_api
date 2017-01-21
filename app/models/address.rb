class Address < ApplicationRecord
  # Após a validação de dados chama o método para pegar a latitude e longitude
  after_validation :geocode

  # Chama a API do geocode e devolve os dados completos do endereço
  # Com os dados nós preenchemos a latitude e longitude
  geocoded_by :full_address do |obj,results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    end
  end

  # Monta uma String com o endereço completo
  def full_address
    "#{self.street}, #{self.neighborhood}, #{self.city} #{number}, #{self.country}"
  end
end
