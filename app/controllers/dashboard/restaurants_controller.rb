class Dashboard::RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
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

  def search
    @search = Restaurant.search(params[:name], params[:address])
    render json: {results: @search.to_json}
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:category, :name, :address, :telephone)
    end
end
