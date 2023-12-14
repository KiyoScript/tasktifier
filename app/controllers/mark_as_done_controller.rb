class MarkAsDoneController < ApplicationController
  before_action :authenticate_user!

  def update
    @task = Task.find_by(id: params[:id])
    @task.mark_as_done_true!
    render json: { success: true, notice: "Task marked as done successfully!" }
  end
end
