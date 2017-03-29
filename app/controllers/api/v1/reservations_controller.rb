class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_api_v1_reservation, only: [:evaluation, :cancel, :accept, :refuse]
  before_action :is_property_owner?, only: [:accept, :refuse]
  before_action :is_owner?, only: [:evaluation, :cancel]

  # GET /get_by_property
  # GET /get_by_property.json
  def get_by_property
    begin
      @api_v1_reservation = current_api_v1_user.properties.find(params[:id]).reservations
      render template: '/api/v1/reservations/index', status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  # PUT /cancel
  # PUT /cancel.json
  def cancel
    begin
      @api_v1_reservation.update(status: :canceled)
      Api::V1::ReservationMailer.cancel_reservation(@api_v1_reservation).deliver_now
      render json: {success: true}, status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  # PUT /refuse
  # PUT /refuse.json
  def refuse
    begin
      @api_v1_reservation.update(status: :refused)
      Api::V1::ReservationMailer.refused_reservation(@api_v1_reservation).deliver_now
      render json: {success: true}, status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  # POST /api/v1/accept.json
  def accept
    if @api_v1_reservation.update(status: :active)
      Api::V1::ReservationMailer.accepted_reservation(@api_v1_reservation).deliver_now
      render :show, status: :ok
    else
      render json: @api_v1_reservation.errors, status: :unprocessable_entity
    end
  end

  # POST /evaluation
  # POST /evaluation.json
  def evaluation
    begin
      @api_v1_reservation.evaluate(evaluation_params[:comment], evaluation_params[:rating].to_i) unless @api_v1_reservation.evaluation
      render json: {success: true}, status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  # POST /api/v1/reservation.json
  def create
    @api_v1_reservation = Reservation.new(reservation_params)

    if @api_v1_reservation.save
      Api::V1::ReservationMailer.new_reservation(@api_v1_reservation).deliver_now
      render :show, status: :created
    else
      render json: @api_v1_reservation.errors, status: :unprocessable_entity
    end
  end

  private

    def reservation_params
      params.require(:reservation).permit(:property_id, :checkin_date, :checkout_date).merge(user_id: current_api_v1_user.id)
    end

    def evaluation_params
      params.require(:evaluation).permit(:comment, :rating)
    end

    def set_api_v1_reservation
      @api_v1_reservation = Reservation.find(params[:id])
    end

    def is_property_owner?
      unless @api_v1_reservation.property.user == current_api_v1_user
        render json: {}, status: :forbidden
      end
    end

    def is_owner?
      unless @api_v1_reservation.user == current_api_v1_user
        render json: {}, status: :forbidden
      end
    end
end
