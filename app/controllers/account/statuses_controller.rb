class Account::StatusesController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = User.find(params[:id])
    if @user.status_active?
      @user.status_inactive!
      redirect_to account_deactivation_index_path, notice: "You are taking a break from Tasktifier"
    else
      @user.status_active!
      redirect_to account_profile_index_path, notice: "You are back to Tasktifier"
    end
  end
end
