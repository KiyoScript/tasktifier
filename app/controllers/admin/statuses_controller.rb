class Admin::StatusesController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = User.find(params[:id])
    if @user.status_active?
      @user.status_inactive!
      redirect_to admin_users_path, notice: "#{@user.username} deactivated successfully"
    else
      @user.status_active!
      redirect_to admin_users_path, notice: "#{@user.username} activated successfully"
    end
  end
end
