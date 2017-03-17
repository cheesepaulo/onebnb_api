json.trips do
  json.wishlist do
    json.array! @properties[:wishlist] do |property|
      json.extract! property, :id, :price, :name, :description, :user_id, :accommodation_type , :guest_max, :beds, :bedroom, :status , :bathroom , :rating, :priority, :created_at , :updated_at

      json.address do
        json.extract! property.address, :id, :country, :city, :neighborhood, :street, :number, :zipcode, :latitude, :longitude, :created_at, :updated_at, :state
      end

      json.photos property.photos.map {|p| p.photo.url}
    end
  end

  json.pending do
    json.array! @properties[:pending] do |arr|
      json.extract! arr[:property], :id, :price, :name, :description, :user_id, :accommodation_type , :guest_max, :beds, :bedroom, :status , :bathroom , :rating, :priority, :created_at , :updated_at

      json.address do
        json.extract! arr[:property].address, :id, :country, :city, :neighborhood, :street, :number, :zipcode, :latitude, :longitude, :created_at, :updated_at, :state
      end

      json.reservation do
        json.id arr[:reservation].id
        json.checkin_date arr[:reservation].checkin_date
        json.checkout_date arr[:reservation].checkout_date
      end

      json.photos arr[:property].photos.map {|p| p.photo.url}
    end
  end

  json.next do
    json.array! @properties[:next] do |arr|
      json.extract! arr[:property], :id, :price, :name, :description, :user_id, :accommodation_type , :guest_max, :beds, :bedroom, :status , :bathroom , :rating, :priority, :created_at , :updated_at

      json.address do
        json.extract! arr[:property].address, :id, :country, :city, :neighborhood, :street, :number, :zipcode, :latitude, :longitude, :created_at, :updated_at, :state
      end

      json.reservation do
        json.id arr[:reservation].id
        json.checkin_date arr[:reservation].checkin_date
        json.checkout_date arr[:reservation].checkout_date
      end

      json.photos arr[:property].photos.map {|p| p.photo.url}
    end
  end
 
  json.previous do
    json.array! @properties[:previous] do |arr|
      json.extract! arr[:property], :id, :price, :name, :description, :user_id, :accommodation_type , :guest_max, :beds, :bedroom, :status , :bathroom , :rating, :priority, :created_at , :updated_at

      json.address do
        json.extract! arr[:property].address, :id, :country, :city, :neighborhood, :street, :number, :zipcode, :latitude, :longitude, :created_at, :updated_at, :state
      end

      json.reservation do
        json.id arr[:reservation].id
        json.checkin_date arr[:reservation].checkin_date
        json.checkout_date arr[:reservation].checkout_date
      end

      json.photos arr[:property].photos.map {|p| p.photo.url}
    end
  end
end
