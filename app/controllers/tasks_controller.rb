class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task
  before_action :ensure_frame_response, only: [:new, :edit]

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('tasks', partial: 'tasks/task', locals: { task: @task }) }
        format.html { redirect_to root_path, notice: "Task added successfully!" }
      else
        format.html { redirect_to root_path, alert: "Something went wrong!" }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: 'tasks/task', locals: { task: @task }) }
        format.html { redirect_to root_path, notice: "Task updated successfully!" }
      else
        format.html { redirect_to root_path, alert: "Something went wrong!" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @task.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@task) }
        format.html { redirect_to root_path, notice: "Task deleted successfully!" }
      else
        format.html { redirect_to root_path, alert: "Something went wrong!" }
      end
    end
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(
      :title,
      :due_date
    ).merge(user_id: current_user.id)
  end

  def ensure_frame_response
    return unless Rails.env.development?
    redirect_to root_path unless turbo_frame_request?
  end
end
