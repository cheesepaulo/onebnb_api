require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "GET #current_user" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and tokens" do
      before do
        # Aqui nós estamos colocando no header os tokens (Sem isso a chamada seria bloqueada)
        request.headers.merge!(@auth_headers)
      end

      it "get the current user" do
        get :current_user
        expect(JSON.parse(response.body)["email"]).to eql(@user.email)
      end
    end

    context "with invalid params and tokens" do
      before do
      end

      it "get a status 401" do
        get :current_user
        expect(response.status).to eql(401)
      end
    end
  end

  describe "PUT #update" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      # Aqui estamos setando a chamada como json (isso pega a URL users.json ao invés de users)
      request.env["HTTP_ACCEPT"] = 'application/json'
      # Aqui estamos preparando os atributos que serão atualizados no User
      @new_attributes = {
                          name:        FFaker::Name.name,
                          description: FFaker::Lorem.paragraph,
                          phone:       FFaker::PhoneNumber.phone_number,
                          birthday:    DateTime.new(2001,2,3),
                          email:       FFaker::Internet.email
                        }
    end

    context "with valid params and tokens" do
      before do
        # Aqui nós estamos colocando no header os tokens (Sem isso a chamada seria bloqueada)
        request.headers.merge!(@auth_headers)
      end

      it "updates the requested user" do
        put :update, params: {user: @new_attributes}
        @user.reload
        # Testa todos os atributos para ver se eles foram atualizados
        expect(@user.name).to eql(@new_attributes[:name])
        expect(@user.description).to eql(@new_attributes[:description])
        expect(@user.phone).to eql(@new_attributes[:phone])
        expect(@user.birthday).to eql(@new_attributes[:birthday])
        expect(@user.email).to eql(@new_attributes[:email])
      end

      it "updates the requested user with photo" do
        @attributes_with_photo = @new_attributes.merge!(photo: ('data:image/png;base64,' + Base64.encode64(file_fixture('file.png').read)))
        put :update, params: {id: @user.id, user: @attributes_with_photo}
        @user.reload
        expect(@user.photo.present?).to eql(true)
      end

      it "updates the requested user address" do
        # Aqui estamos preparando os atributos do endereço
        @new_address =  {
                          country: FFaker::Address::country,
                          state: FFaker::AddressBR::state,
                          city: FFaker::AddressBR::city,
                          neighborhood: FFaker::Address::neighborhood,
                          street: FFaker::Address::street_name,
                          number: FFaker::Address::building_number
                        }
         put :update, params: {user: @new_attributes, address: @new_address}
        @user.reload
        expect(@user.address.country).to eql(@new_address[:country])
        expect(@user.address.city).to eql(@new_address[:city])
        expect(@user.address.state).to eql(@new_address[:state])
        expect(@user.address.neighborhood).to eql(@new_address[:neighborhood])
        expect(@user.address.street).to eql(@new_address[:street])
        expect(@user.address.number).to eql(@new_address[:number])
      end
    end

    context "with invalid token" do
      it "not updates the requested user" do
        @name = FFaker::Name.name
        put :update, params: {id: @user.id, user: @new_attributes}
        expect(response.status).to eql(401)
      end
    end
  end
end
