class WatchesController < ApplicationController
  include Orderable
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_watch, only: %i[ show update destroy ]
  #before_action :require_permission, only: [:update, :destroy]


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
    @watch.user_id = current_user.id

    if @watch.save
      render json: @watch, status: :created, location: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /watches/1
  def update
    if current_user.id != @watch.user_id
        render json: { status: 403, error: "Access Denied", exception: "User is not creator of this watch" }, status: 403
    elsif @watch.update(watch_params)
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

    def require_permission
      if current_user.id != @watch.user_id
        render json: { status: 403, error: "Access Denied", exception: "User is not creator of this watch" }
      end
    end
end
