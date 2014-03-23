class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :destroy, :finish, :repeat]

  def index
    @tasks = Task.where({status: 'N'}).order("updated_at").page(params[:page]).per(10)
  end

  def show
    render text: 'show'
  end

  def new
    # @restaurant = Restaurant.newtaskcon
  end

  def create
    @task = Task.new({restaurant_id: params[:restaurant], user_id: session[:UserInfo][:id]})

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
    @task.destroy
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
