class Api::V1::ReservationsController < ApplicationController
  before_action :set_api_v1_reservation, only: [:evaluation, :create]

  # GET /api/v1/my_reservations
  # GET /api/v1/my_reservations.json
  def my_reservations
    @api_v1_properties = current_api_v1_user.reservations.
                                      order("reservations.created_at DESC")
    render template: '/api/v1/reservations/index', status: 200
  end

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
      render :show, status: :created
    else
      render json: @api_v1_reservation.errors, status: :unprocessable_entity
    end
  end

  private

    def set_api_v1_reservation
      @api_v1_reservation = Reservation.where(id: params[:id], user: current_api_v1_user).last
    end

    def reservation_params
      params.require(:reservation).permit(:property_id, :checkin_date, :checkout_date).merge(user_id: current_api_v1_user.id)
    end

    def evaluation_params
      params.require(:evaluation).permit(:comment, :rating)
    end
end
