json.property do
  json.extract! api_v1_property, :id, :price, :name, :description, :user_id, :accommodation_type , :guest_max, :beds, :bedroom, :status , :bathroom , :rating, :created_at , :updated_at

  json.address do
    json.extract! api_v1_property.address, :id, :country, :city, :neighborhood, :street, :number, :zipcode, :latitude, :longitude, :created_at, :updated_at, :state
  end
  json.facility do
    json.extract! api_v1_property.facility, :id, :wifi, :washing_machine, :clothes_iron, :towels, :air_conditioning, :refrigerator, :created_at, :updated_at, :heater
  end

  json.user do
    json.extract! api_v1_property.user, :id, :name, :email, :photo, :created_at, :updated_at
    json.address do
      if api_v1_property.user.address
        json.country api_v1_property.user.address.country
        json.city api_v1_property.user.address.city
      end
    end
  end

  json.photos api_v1_property.photos.map {|p| p.photo.url}

  json.comments do
    json.array! api_v1_property.comments do |comment|
      json.body comment.body
      json.name comment.user.name
      json.photo comment.user.photo
      json.date comment.created_at.strftime("%m/%Y")
    end
  end
end
