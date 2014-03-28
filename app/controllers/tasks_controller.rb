class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :destroy, :finish, :repeat]

  def index
    @tasks = Task.where({status: 'N'}).order("updated_at").page(params[:page]).per(10)

    @hash = Gmaps4rails.build_markers(@tasks) do |task, marker|
      marker.lat task.restaurant.latitude
      marker.lng task.restaurant.longitude
    end

    logger.debug { "++++++ #{@hash.to_json}" }
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
    render text: ''
  end

  def fetch
    @fetch_info = FetchUrl.new(params[:url])

    render json: {info: @fetch_info}
  end

  def finishs
    @tasks = Task.where({status: 'Y'}).order("updated_at desc").page(params[:page]).per(10)
  end

  def finish
    result = {status: 'N'}
    if params.has_key?('overall')
      score = Score.new({
                    restaurant: @task.restaurant,
                    user: @task.user,
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
    @tasks = Task.where(status: 'Y').limit(3).offset(offset)
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
