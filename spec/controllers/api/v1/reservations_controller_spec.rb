require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe "GET #get_by_property" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and 4 reservations" do
      before do
        request.headers.merge!(@auth_headers)
        @property1 = create(:property, status: :active, rating: 5, user: @user)
        @reservation1 = create(:reservation, property: @property1, evaluation: true)
        @reservation2 = create(:reservation, property: @property1, evaluation: true)
        @reservation3 = create(:reservation, property: @property1, evaluation: true)
        @reservation4 = create(:reservation, property: @property1, evaluation: true)
      end

      it "receive 4 reservations" do
        get :get_by_property, params: {id: @property1.id}
        expect(JSON.parse(response.body).count).to eql(4)
      end

      it "get a reservation with correspondents json fields" do
        get :get_by_property, params: {id: @property1.id}
        @reservation = Reservation.last

        puts @reservation.user.id
        puts JSON.parse(response.body)[3]
        # o user id é igual ao retornado no response

        expect(JSON.parse(response.body).count).to eql(4)
        expect(JSON.parse(response.body)[3]["property_id"]).to eql(@reservation.property_id)
        expect(JSON.parse(response.body)[3]["checkin_date"]).to eql(@reservation.checkin_date.strftime)
        expect(JSON.parse(response.body)[3]["checkout_date"]).to eql(@reservation.checkout_date.strftime)
        expect(JSON.parse(response.body)[3]["user"]["user_id"]).to eql(@reservation.user.id)
        # se deixar só com "user" .to eql @resevation.user vem igual porém com 3 campos a mais
        # por isso tive que buscar o user mais especificamente
      end
    end
  end

  describe "POST #create" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params" do
      before do
        request.headers.merge!(@auth_headers)
        @property1 = create(:property, status: :active, rating: 5)
      end

      it "create a valid reservation" do
        post :create, params: {reservation: {property_id: @property1.id, checkin_date: Date.today - 10.day, checkout_date: Date.today + 10.day}}
        expect(Reservation.all.count).to eql(1)
      end

      it "create a reservation with correspondents fields" do
        new_reservation_params = {reservation: {property_id: @property1.id, checkin_date: Date.today - 10.day, checkout_date: Date.today + 10.day}}

        post :create, params: new_reservation_params

        @reservation = Reservation.last

        expect(@reservation.property_id).to eql(new_reservation_params[:reservation][:property_id])
        expect(@reservation.checkin_date).to eql(new_reservation_params[:reservation][:checkin_date])
        expect(@reservation.checkout_date).to eql(new_reservation_params[:reservation][:checkout_date])
        expect(@reservation.user).to eql(@user)
      end
    end
  end

  describe "GET #evaluation" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with 4 existing reservations and rating 5" do
      before do
        request.headers.merge!(@auth_headers)

        @property1 = create(:property, status: :active, rating: 5)
        @reservation1 = create(:reservation, property: @property1, evaluation: true, user: @user)
        @reservation2 = create(:reservation, property: @property1, evaluation: true, user: @user)
        @reservation3 = create(:reservation, property: @property1, evaluation: true, user: @user)
        @reservation4 = create(:reservation, property: @property1, evaluation: true, user: @user)
      end

      it "return rating 4 when new rating is 0" do
        @reservation5 = create(:reservation, property: @property1, evaluation: false, user: @user)

        post :evaluation, params: {id: @reservation5.id, evaluation: {comment: FFaker::Lorem.paragraph, rating: 0}}
        @property1.reload
        expect(@property1.rating).to eql(4)
      end

      it "return rating 5 when new rating is 5" do
        @reservation5 = create(:reservation, property: @property1, evaluation: false, user: @user)

        post :evaluation, params: {id: @reservation5.id, evaluation: {comment: FFaker::Lorem.paragraph, rating: 5}}
        @property1.reload
        expect(@property1.rating).to eql(5)
      end

      it "return comment" do
        @reservation5 = create(:reservation, property: @property1, evaluation: false, user: @user)
        comment = FFaker::Lorem.paragraph
        post :evaluation, params: {id: @reservation5.id, evaluation: {comment: comment, rating: 5}}
        @property1.reload
        expect(Comment.last.body).to eql(comment)
      end
    end
  end
end
