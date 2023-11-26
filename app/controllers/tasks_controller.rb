class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task
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
        format.html { redirect_to root_path, alert: "Oops! Something went wrong while adding the task." }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: 'tasks/task', locals: { task: @task }) }
        format.html { redirect_to root_path, notice: "Task updated successfully!" }
      else
        format.html { redirect_to root_path, alert: "Oops! Something went wrong while updating the task." }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @task.destroy
        format.html { redirect_to root_path, notice: "Task deleted successfully!" }
      else
        format.html { redirect_to root_path, alert: "Oops! Something went wrong while deleting the task." }
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
      :notes,
      :due_date,
      :start_time,
      :starred,
      :repeat,
      :mark_as_done,
      :reminder_at,
      :attachment
    ).merge(user_id: current_user.id)
  end
end