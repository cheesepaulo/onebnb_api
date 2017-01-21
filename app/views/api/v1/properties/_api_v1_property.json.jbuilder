json.property do
  json.extract! api_v1_property, :id, :price, :name, :description, :user_id, :accommodation_type , :guest_max, :beds, :bedroom, :status , :bathroom , :created_at , :updated_at

  json.address do
    json.extract! api_v1_property.address, :id, :country, :city, :neighborhood, :street, :number, :zipcode, :latitude, :longitude, :created_at, :updated_at, :state
  end
  json.facility do
    json.extract! api_v1_property.facility, :id, :wifi, :washing_machine, :clothes_iron, :towels, :air_conditioning, :refrigerator, :created_at, :updated_at, :heater
  end

  json.user do
    json.extract! api_v1_property.user, :id, :name, :email, :image, :created_at, :updated_at
  end

  json.photos api_v1_property.photos.map {|p| p.photo.url}
end
