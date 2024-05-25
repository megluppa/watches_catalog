class WatchesController < ApplicationController
  include Orderable
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_watch, only: %i[ show update destroy ]

  # Filters:
  # /api/v1/experiences?by_price[from]=100&by_price[to]=999
  # /api/v1/experiences?by_category=1,2,3
  # /api/v1/experiences?by_city=1,2,3
  # /api/v1/experiences?by_duration[from]=10&by_duration[to]=60
  #
  has_scope :by_category, only: :index
  has_scope :by_name, only: :index
  has_scope :by_price, using: [:from, :to], only: :index
  has_scope :by_description, only: :index
  has_scope :by_url, only: :index

  # GET /watches
  def index
    @watches = 
      apply_scopes(Watch)
      .order(ordering_params(params))
      .all

    render json: @watches
  end

  # GET /watches/1
  def show
    render json: @watch
  end

  # POST /watches
  def create
    @watch = Watch.new(watch_params)

    if @watch.save
      render json: @watch, status: :created, location: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /watches/1
  def update
    if @watch.update(watch_params)
      render json: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  # DELETE /watches/1
  def destroy
    @watch.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watch
      @watch = Watch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def watch_params
      params.require(:watch).permit(:name, :description, :category, :price, :url)
    end
end
