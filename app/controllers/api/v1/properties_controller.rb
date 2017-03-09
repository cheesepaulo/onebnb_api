class Api::V1::PropertiesController < ApplicationController
  before_action :set_api_v1_property, only: [:show, :update, :destroy, :add_to_wishlist, :remove_from_wishlist]
  before_action :authenticate_api_v1_user!, except: [:index, :show, :search, :autocomplete, :featured]

  # GET /api/v1/properties
  # GET /api/v1/properties.json
  def index
    @api_v1_properties = Property.all
  end

  # GET /api/v1/properties/1.json
  def show
  end

  # GET /api/v1/autocomplete.json
  def autocomplete
    results = []
    Property.where(status: :active).each do |property|
      results << property.name
      results << property.address.city
      results << property.address.country
    end
    render json: results, status: 200
  end

  # GET /api/v1/my_properties
  # GET /api/v1/my_properties.json
  def my_properties
    @api_v1_properties = current_api_v1_user.properties.
                                      includes(:reservations).
                                      order("reservations.created_at DESC")

    render template: '/api/v1/properties/index', status: 200
  end

  # GET /api/v1/trips.json
  def trips
    begin
      @properties = {}
      # Próximas
      @properties[:next] = current_api_v1_user.reservations.where(status: :active).map {|r| r.property}
      # Anteriores
      @properties[:previous] = current_api_v1_user.reservations.where(status: :finished).map {|r| r.property}
      # Pending
      @properties[:pending] = current_api_v1_user.reservations.where(status: :pending).map {|r| r.property}
      # Wishlist
      @properties[:wishlist] = current_api_v1_user.wishlists.map {|w| w.property}
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/featured
  # GET /api/v1/featured.json
  def featured
    properties = []
    begin
      # Tenta pegar 3 propriedades com a flag de prioridade
      Property.where(priority: true, status: :active).order("RANDOM()").limit(3).each {|p| properties << p}
      # Verifica quantas propriedades faltam pra completar 3
      missing = 3 - properties.count
      # Pega as propriedades faltantes caso existam
      Property.where(status: :active).order("RANDOM()").limit(missing).each {|p| properties << p} if missing > 0

      @api_v1_properties = properties

      render template: '/api/v1/properties/index', status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end


  # GET /api/v1/search
  def search
    # puts params[:wifi].to_b.class
    # Caso o usuário não coloque nenhuma informação pesquisamos por qualquer uma
    search_condition = params[:search] || '*'
    # Caso não esteja sendo selecionado por página, pegamos a primeira
    page = params[:page] || 1
    # Filtra por status, presença de wifi, máquina de lavar e etc
    conditions = {status: :active}

    # Se o parâmetro estiver presente converte a string true/false para boolean e adiciona ao array de conditions
    conditions['wifi'] = params[:wifi].to_b if params[:wifi].present?
    conditions['washing_machine'] = params[:washing_machine].to_b if params[:washing_machine].present?
    conditions['clothes_iron'] = params[:clothes_iron].to_b if params[:clothes_iron].present?
    conditions['towels'] = params[:towels].to_b if params[:towels].present?
    conditions['air_conditioning'] = params[:air_conditioning].to_b if params[:air_conditioning].present?
    conditions['refrigerato'] = params[:refrigerato].to_b if params[:refrigerato].present?
    conditions['heater'] = params[:heater].to_b if params[:heater].present?


    # Realizamos a busca do ElasticSearch
    @api_v1_properties = (Property.search search_condition, where: conditions,  page: page, per_page: 18)
    render template: '/api/v1/properties/index', status: 200
  end


  # POST /api/v1/properties.json
  def create
    @api_v1_property = Property.new(api_v1_property_params)

    if @api_v1_property.save
      render :show, status: :created, location: @api_v1_property
    else
      render json: @api_v1_property.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/properties/1.json
  def update
    if @api_v1_property.update(api_v1_property_params)
      render :show, status: :ok, location: @api_v1_property
    else
      render json: @api_v1_property.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/properties/1.json
  def destroy
    @api_v1_property.destroy
  end

  # POST /api/v1/properties/:id/wishlist.json
  def add_to_wishlist
    begin
      @api_v1_property.wishlists.find_or_create_by(user: current_api_v1_user)
      render json: {success: true}
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/properties/:id/wishlist.json
  def remove_from_wishlist
    begin
      @api_v1_property.wishlists.find_by(user: current_api_v1_user).delete
      render json: {success: true}, status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_property
      @api_v1_property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_property_params
      params.require(:api_v1_property).permit(:title, :description)
    end
end
