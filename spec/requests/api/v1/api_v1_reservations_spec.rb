require 'rails_helper'

RSpec.describe "Api::V1::Reservations", type: :request do
  describe "GET /reservations/:id/accept" do
    it_behaves_like :deny_without_authorization, :put, "/api/v1/reservations/1/accept"

    context "User is property owner" do
      before do
        @user = create(:user)
        @property = create(:property, user: @user)
        @reservation = create(:reservation, status: :pending, property: @property)
        ActionMailer::Base.deliveries = []
      end

      it "Change status of pending to active" do
        put "/api/v1/reservations/#{@reservation.id}/accept", params: {}, headers: header_with_authentication(@user)
        @reservation.reload
        expect(@reservation.status).to eql("active")
      end

      it "Receive status 200" do
        put "/api/v1/reservations/#{@reservation.id}/accept", params: {}, headers: header_with_authentication(@user)
        expect_status(200)
      end

      it "will send a notification mail to Reservation User" do
        put "/api/v1/reservations/#{@reservation.id}/accept", params: {}, headers: header_with_authentication(@user)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries.last.to).to eq([Reservation.last.user.email])
      end
    end
  end

  describe "GET /reservations/:id/refuse" do
    it_behaves_like :deny_without_authorization, :put, "/api/v1/reservations/1/refuse"

    context "User is property owner" do
      before do
        @user = create(:user)
        @property = create(:property, user: @user)
        @reservation = create(:reservation, status: :refused, property: @property)
        ActionMailer::Base.deliveries = []
      end

      it "Change status of pending to refused" do
        put "/api/v1/reservations/#{@reservation.id}/refuse", params: {}, headers: header_with_authentication(@user)
        @reservation.reload
        expect(@reservation.status).to eql("refused")
      end

      it "Receive status 200" do
        put "/api/v1/reservations/#{@reservation.id}/refuse", params: {}, headers: header_with_authentication(@user)
        expect_status(200)
      end

      it "will send a notification mail to Reservation User" do
        put "/api/v1/reservations/#{@reservation.id}/refuse", params: {}, headers: header_with_authentication(@user)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries.last.to).to eq([Reservation.last.user.email])
      end
    end
  end
end
