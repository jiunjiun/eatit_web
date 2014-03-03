class Dashboard::TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    # @restaurant = Restaurant.new
  end

  def create
    # @restaurant = Restaurant.new(restaurant_params)
    # if @restaurant.save
    #   @task = Task.new({user: session[:UserInfo].id})
    # else

    # end
    render text: {user: session[:UserInfo][:id], restaurant: @restaurant.id}.to_json
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :category)
    end
end
