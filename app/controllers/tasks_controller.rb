class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :destroy, :finish, :repeat]

  def index
    @tasks = Task.where({status: 'N', user_id: session[:UserInfo][:id]}).order("updated_at").page(params[:page]).per(10)

    # @hash = Gmaps4rails.build_markers(@tasks) do |task, marker|
    #   marker.lat task.restaurant.latitude
    #   marker.lng task.restaurant.longitude
    # end
  end

  def show
    @task
  end

  def new

  end

  def create
    restaurant = Restaurant.new({name: params[:name], address: params[:address], telephone: params[:telephone]})
    restaurant.save
    task = Task.new({url: params[:respone_url], restaurant: restaurant, user_id: session[:UserInfo][:id]})
    task.save

    redirect_to tasks_path
  end

  def edit
  end

  def update
  end

  def destroy
    @task.destroy
    render nothing: true
  end

  def fetch
    task = Task.where({url: params[:url]})
    if task.count > 0
      @fetch_info = task.first
    else
      fu = FetchUrl.new(params[:url])
      @fetch_info = fu.get_result
    end

    result = {}
    if !@fetch_info.empty?
      result = {info: @fetch_info}
    end

    render json: result
  end

  def finished
    @tasks = Task.where({status: 'Y'}).order("updated_at desc").page(params[:page]).per(10)
  end

  def finish
    logger.debug { "+++++ #{params.to_json}" }
    logger.debug { "+++++ #{@task.user.to_json}" }
    result = {status: 'N'}
    if params.has_key?('overall')
      score = Score.new({
                    user_id: @task.user_id,
                    task_id: @task.id,
                    restaurant_id: @task.restaurant_id,
                    overall: params[:overall],
                    delicious: params[:delicious],
                    service: params[:service],
                    queues: params[:queues],
                    feel: params[:feel],
                    comment: params[:comment]
                    })
      Score.transaction do
        begin
          scorelog = score.save!
          tasklog = @task.update_attributes!(status: 'Y')
          result = {status: 'Y', id: @task.id}
        rescue ActiveRecord::RecordInvalid => invalid
          # do something
        end
      end
    end
    render json: result.to_json
  end

  def before
    offset = 3
    offset *= params[:offset].to_i if params[:offset]
    @tasks = Task.where({status: 'Y', user_id: session[:UserInfo][:id]}).limit(3).offset(offset)
  end

  def repeat
    @task if @task.update_attributes({status: "N"})
    respond_to do |format|
      format.json
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end
end
