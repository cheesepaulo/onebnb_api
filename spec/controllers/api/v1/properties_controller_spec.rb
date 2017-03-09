require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :controller do
  describe "GET #my_properties" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with 4 properties of the current_user" do
      before do
        @property1 = create(:property, status: :active, user: @user)
        @property2 = create(:property, status: :active, user: @user)
        @property3 = create(:property, status: :inactive, user: @user)
        @property4 = create(:property, status: :inactive, user: @user)

        @reservation1 = create(:reservation, property: @property1, status: :pending)
        @reservation2 = create(:reservation, property: @property2, status: :pending)
        @reservation3 = create(:reservation, property: @property3, status: :pending)
        @reservation4 = create(:reservation, property: @property4, status: :pending)

        request.headers.merge!(@auth_headers)
      end

      it "return 4 properties" do
        get :my_properties
        expect(JSON.parse(response.body).count).to eql(4)
      end

      it "return by last reservation order" do
        get :my_properties
        expect(@property1.id).to eql(JSON.parse(response.body)[3]["property"]["id"])
        expect(@property2.id).to eql(JSON.parse(response.body)[2]["property"]["id"])
        expect(@property3.id).to eql(JSON.parse(response.body)[1]["property"]["id"])
        expect(@property4.id).to eql(JSON.parse(response.body)[0]["property"]["id"])
      end
    end
  end

  describe "GET #trips" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with 2 reservations active, 2 reservations pending, 2 reservations finished and 2 properties in wishlist" do
      before do
        @property1 = create(:property, status: :active, priority: true)
        @property2 = create(:property, status: :active, priority: true)
        @property3 = create(:property, status: :active, priority: true)
        @property4 = create(:property, status: :active, priority: false)
        @property5 = create(:property, status: :active, priority: false)
        @property6 = create(:property, status: :active, priority: false)
        @property7 = create(:property, status: :active, priority: false)
        @property8 = create(:property, status: :active, priority: false)

        @pending1 = create(:reservation, property: @property1, user: @user, status: :pending)
        @pending2 = create(:reservation, property: @property2, user: @user, status: :pending)

        @next1 = create(:reservation, property: @property3, user: @user, status: :active)
        @next2 = create(:reservation, property: @property4, user: @user, status: :active)

        @previous1 = create(:reservation, property: @property5, user: @user, status: :finished)
        @previous2 = create(:reservation, property: @property6, user: @user, status: :finished)

        @wishlist1 = Wishlist.create(user: @user, property: @property7)
        @wishlist2 = Wishlist.create(user: @user, property: @property8)
        request.headers.merge!(@auth_headers)
      end

      it "return 2 properties in 'next' trips and right properties" do
        get :trips
        expect(JSON.parse(response.body)["trips"]["next"].count).to eql(2)
        expect(JSON.parse(response.body)["trips"]["next"][0]['id']).to eql(@next1.property.id)
        expect(JSON.parse(response.body)["trips"]["next"][1]['id']).to eql(@next2.property.id)
      end

      it "return 2 properties in 'previous' trips" do
        get :trips
        expect(JSON.parse(response.body)["trips"]["previous"].count).to eql(2)
        expect(JSON.parse(response.body)["trips"]["previous"][0]['id']).to eql(@previous1.property.id)
        expect(JSON.parse(response.body)["trips"]["previous"][1]['id']).to eql(@previous2.property.id)
      end

      it "return 2 properties in 'pending' trips" do
        get :trips
        expect(JSON.parse(response.body)["trips"]["pending"].count).to eql(2)
        expect(JSON.parse(response.body)["trips"]["pending"][0]['id']).to eql(@pending1.property.id)
        expect(JSON.parse(response.body)["trips"]["pending"][1]['id']).to eql(@pending2.property.id)
      end

      it "return 2 properties in the wishlist" do
        get :trips
        expect(JSON.parse(response.body)["trips"]["wishlist"].count).to eql(2)
        expect(JSON.parse(response.body)["trips"]["wishlist"][0]['id']).to eql(@wishlist1.property.id)
        expect(JSON.parse(response.body)["trips"]["wishlist"][1]['id']).to eql(@wishlist2.property.id)
      end
    end
  end

  describe "GET #featured" do
      before do
        request.env["HTTP_ACCEPT"] = 'application/json'
      end

      context "with 5 existing properties and 3 with priority" do
        before do
          @property1 = create(:property, status: :active, priority: true)
          @property2 = create(:property, status: :active, priority: true)
          @property3 = create(:property, status: :active, priority: true)
          @property4 = create(:property, status: :active, priority: false)
          @property5 = create(:property, status: :active, priority: false)
        end

        it "return 3 elements of result" do
          get :featured
          expect(JSON.parse(response.body).count).to eql(3)
        end

        it "return the 3 properties thar are priority" do
          get :featured
          expect(JSON.parse(response.body)[0]["property"]["priority"]).to eql(true)
          expect(JSON.parse(response.body)[1]["property"]["priority"]).to eql(true)
          expect(JSON.parse(response.body)[2]["property"]["priority"]).to eql(true)
        end
      end

      context "with 5 properties and 2 with priority" do
        before do
          @property1 = create(:property, status: :active, priority: true)
          @property2 = create(:property, status: :active, priority: true)
          @property3 = create(:property, status: :active, priority: false)
          @property4 = create(:property, status: :active, priority: false)
          @property5 = create(:property, status: :active, priority: false)
        end

        it "return 2 properties with priority and 1 without priority" do
          get :featured
          expect(JSON.parse(response.body)[0]["property"]["priority"]).to eql(true)
          expect(JSON.parse(response.body)[1]["property"]["priority"]).to eql(true)
          expect(JSON.parse(response.body)[2]["property"]["priority"]).to eql(false)
        end
      end
    end

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

      it "receive one result when property is active and wifi is enable" do
        @address = create(:address, city: 'Sao Paulo')
        @facility = create(:facility, wifi: true)
        @property = create(:property, address: @address, status: :active, facility: @facility)
        # Force reindex
        Property.reindex

        get :search, params: {search: 'Sao Paulo', wifi: true}
        expect(JSON.parse(response.body).count).to eql(1)
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

  describe "GET #autocomplete" do
    before do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with 2 existing properties and 1 active" do
      before do
        @property1 = create(:property, status: :active)
        @property2 = create(:property, status: :inactive)
      end

      it "return 3 elements of result" do
        get :autocomplete
        expect(JSON.parse(response.body).count).to eql(3)
      end

      it "return name of Property, city and country of property in 3 first elements" do
        get :autocomplete
        expect(JSON.parse(response.body)[0]).to eql(@property1.name)
        expect(JSON.parse(response.body)[1]).to eql(@property1.address.city)
        expect(JSON.parse(response.body)[2]).to eql(@property1.address.country)
      end
    end

    context "with 2 existing properties and 0 active" do
      before do
        @property1 = create(:property, status: :inactive)
        @property2 = create(:property, status: :inactive)
      end

      it "return 0 elements of result" do
        get :autocomplete
        expect(JSON.parse(response.body).count).to eql(0)
      end
    end
  end
end
