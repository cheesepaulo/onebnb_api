class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!
  # before_action :set_user, only: [:update]

  # GET /api/v1/users/:id/wishlist
  def wishlist
    @api_v1_properties = current_api_v1_user.wishlists.map {|w| w.property}
    render template: '/api/v1/properties/index', status: 200
  end

  def update
    @user = current_api_v1_user
    begin
      if params[:address]
        if @user.address.present?
          @user.address.update(address_params)
        else
          @user.update(address: Address.create(address_params))
        end
      end
      @user.update(user_params)
      render template: '/api/v1/users/show', status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  def current_user
    @user = current_api_v1_user
    render template: '/api/v1/users/show', status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   @user = User.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :photo, :description, :phone, :email, :gender, :birthday)
    end

    def address_params
      params.require(:address).permit(:country, :city, :state, :neighborhood, :street, :number)
    end
end
