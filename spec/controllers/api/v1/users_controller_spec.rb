require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "PUT #update" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      # Aqui estamos setando a chamada como json (isso pega a URL users.json ao invés de users)
      request.env["HTTP_ACCEPT"] = 'application/json'
      # Aqui estamos preparando os atributos que serão atualizados no User
      @new_attributes = {name: FFaker::Name.name}
    end


    #TODO fazer um teste como parametros inválidos que deve falhar
    context "with valid params and tokens" do
      before do
        # Aqui nós estamos colocando no header os tokens (Sem isso a chamada seria bloqueada)
        request.headers.merge!(@auth_headers)
      end

      it "updates the requested user" do
        put :update, params: {id: @user.id, user: @new_attributes}
        @user.reload
        expect(@user.name).to eql(@new_attributes[:name])
      end

      it "updates the requested user with photo" do
        @attributes_with_photo = @new_attributes.merge!(photo: ('data:image/png;base64,' + Base64.encode64(file_fixture('file.png').read)))
        put :update, params: {id: @user.id, user: @attributes_with_photo}
        @user.reload
        expect(@user.photo.present?).to eql(true)
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

  describe "GET #wishist" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
      @new_attributes = {name: FFaker::Name.name}
    end

    context "with valid params and tokens" do
      before do
        # Aqui nós estamos colocando no header os tokens (Sem isso a chamada seria bloqueada)
        request.headers.merge!(@auth_headers)
        @wishlist = create(:wishlist, user: @user)
        @wishlist2 = create(:wishlist, user: @user)
      end

      it "get a list with two properties" do
        get :wishlist
        expect(JSON.parse(response.body).count).to eql(2)
      end
    end

    context "with invalid params and tokens" do
      before do
        @wishlist = create(:wishlist, user: @user)
        @wishlist2 = create(:wishlist, user: @user)
      end

      it "get a status 401" do
        get :wishlist
        expect(response.status).to eql(401)
      end
    end
  end
end
