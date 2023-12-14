class MarkAsDoneController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ update ]


  def update
    @task.mark_as_done_true!
    redirect_to root_path, notice: "Task marked as done successfully!"
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
  end
end
