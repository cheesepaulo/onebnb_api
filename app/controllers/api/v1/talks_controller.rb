class Api::V1::TalksController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_api_v1_talk, only: [:messages]
  before_action :is_talk_participant?, only: [:messages]

  def index
    page = (params[:page])? params[:page] : 1

    @talks = Talk.includes(:messages)
                  .joins(:property)
                  .where(["properties.user_id = ? or talks.user_id = ?", current_api_v1_user.id, current_api_v1_user.id])
                  .group("talks.id, messages.created_at, messages.id")
                  .order("messages.created_at DESC")
                  .paginate(:page => page, :per_page => 8)
  end

  def messages  
  end


  private
    def set_api_v1_talk
      @talk = Talk.find(params['id'])
    end

    def is_talk_participant?
      if @talk.user != current_api_v1_user and @talk.property.user != current_api_v1_user
        render json: {message: 'unauthorized'}, status: 401 and return
      end
    end

end
