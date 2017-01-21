require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :controller do
  describe "POST #wishlist" do
    before do
      @user = create(:user)
      @property = create(:property)

      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and tokens" do
      before do
        request.headers.merge!(@auth_headers)
      end

      it "add to wishlist" do
        post :add_to_wishlist, params: {id: @property.id}
        @property.reload
        expect(@property.wishlists.last.id).to eql(Wishlist.last.id)
      end
    end

    context "with invalid tokens" do
      it "can't add to wishlist" do
        post :add_to_wishlist, params: {id: @property.id}
        expect(response.status).to eql(401)
      end
    end
  end

  describe "DELETE #wishlist" do
    before do
      @user     = create(:user)
      @property = create(:property)
      @wishlist = create(:wishlist, user: @user, property: @property)

      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and tokens" do
      before do
        request.headers.merge!(@auth_headers)
      end

      it "remove from wishlist" do
        delete :remove_from_wishlist, params: {id: @property.id}
        expect(Wishlist.all.count).to eql(0)
      end
    end

    context "with invalid tokens" do
      it "can't add to wishlist" do
        delete :remove_from_wishlist, params: {id: @property.id}
        expect(response.status).to eql(401)
      end

      it "whishlist keep existing" do
        delete :remove_from_wishlist, params: {id: @property.id}
        expect(Wishlist.all.count).not_to eql(0)
      end
    end
  end

  describe "GET #search" do
    before do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with a property associated a search query" do
      it "receive one result when property active" do
        @address = create(:address, city: 'Sao Paulo')
        @property = create(:property, address: @address, status: :active)
        # Force reindex
        Property.reindex

        get :search, params: {search: 'Sao Paulo'}
        expect(JSON.parse(response.body).count).to eql(1)
      end

      it "receive zero result when property not active" do
        @address = create(:address, city: 'Sao Paulo')
        @property = create(:property, address: @address, status: :inactive)
        # Force reindex
        Property.reindex

        get :search, params: {search: 'Sao Paulo'}
        expect(JSON.parse(response.body).count).to eql(0)
      end
    end

    context "without a property associated a search query" do
      it "receive zero result" do
        @address = create(:address, city: 'Sao Paulo')
        @property = create(:property, address: @address)
        # Force reindex
        Property.reindex

        get :search, params: {search: 'Manaus'}
        expect(JSON.parse(response.body).count).to eql(0)
      end
    end
  end
end
