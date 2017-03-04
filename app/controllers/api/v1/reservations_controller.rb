class Api::V1::ReservationsController < ApplicationController
  before_action :set_api_v1_reservation, only: [:evaluation]

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

    def evaluation_params
      params.require(:evaluation).permit(:comment, :rating)
    end
end
