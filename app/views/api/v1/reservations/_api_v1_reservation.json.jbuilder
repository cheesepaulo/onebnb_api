json.extract! api_v1_reservation, :id, :property_id, :user_id, :checkin_date, :checkout_date, :status, :created_at , :updated_at

json.user do
  json.extract! api_v1_reservation.user, :id, :name, :email, :photo, :created_at, :updated_at
  json.address do
    if api_v1_reservation.user.address
      json.country api_v1_reservation.user.address.country
      json.city api_v1_reservation.user.address.city
    end
  end
end
