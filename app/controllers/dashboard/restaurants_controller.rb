class Dashboard::RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.order("count").page(params[:page]).per(10)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @scores = Score.sum(@restaurant)
    @score_comments = Score.comment(@restaurant)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to dashboard_restaurants_path
    else

    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  # def search
  #   @search = Restaurant.search(params[:name], params[:address])
  #   render json: {results: @search.to_json}
  # end
  # def autocomplete_restaurants_name
  #   # @search = Restaurant.search(params[:term], params[:term])
  #   @search = Restaurant.where('name like ?' , "%#{params[:term]}%")
  #   render json: {results: @search.to_json}
  # end

  def search
    @search = Restaurant.search(params[:name], params[:address])
    render json: {results: @search.to_json}
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:category, :name, :area, :address, :telephone)
    end
end
