class Api::V1::TalksController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    page = (params[:page])? params[:page] : 1
    
    @talks = Talk.includes(:messages)
                  .joins(:property)
                  .where(["properties.user_id = ? or talks.user_id = ?", current_api_v1_user.id, current_api_v1_user.id])
                  .group("talks.id, messages.created_at, messages.id")
                  .order("messages.created_at DESC")
                  .paginate(:page => page, :per_page => 8)
  end
end
