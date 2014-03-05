class Dashboard::TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :destroy, :finish]

  def index
    @tasks = Task.where({status: 'N'}).all
  end

  def show
  end

  def new
    # @restaurant = Restaurant.newtaskcon
  end

  def create
    @task = Task.new({ restaurant_id: params[:restaurant], user_id: session[:UserInfo][:id]})

    if @task.save
      redirect_to dashboard_tasks_path
    else

    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def finish
    @task.update_attributes(status: 'Y')
    redirect_to dashboard_tasks_path
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def restauratn_params
      params.permit(:restaurant)
    end
end
