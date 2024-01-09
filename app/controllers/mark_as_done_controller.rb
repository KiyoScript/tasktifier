class MarkAsDoneController < ApplicationController
  before_action :authenticate_user!

  def update
    @task = Task.find_by(id: params[:id])
    @task.mark_as_done_true!
    @task.status_completed!
    redirect_to tasks_path, notice: "Task marked as done successfully!"
  end
end
