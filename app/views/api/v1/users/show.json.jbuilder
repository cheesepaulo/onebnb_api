json.extract! @user, :id, :name, :email, :description, :phone, :gender, :birthday, :photo, :created_at, :updated_at

json.address do
  json.extract! @user.address, :country, :city, :state, :neighborhood, :street, :number if @user.address
end
