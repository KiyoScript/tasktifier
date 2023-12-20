class Account::ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :account_deactivation!

  def index;end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Your Profile has been updated'
    else
      flash[:success] = current_user.errors.full_messages.first
    end
    redirect_back fallback_location: account_profile_index_path
  end

  def destroy
    current_user.destroy
    redirect_to user_session_path, notice: "Your account has been deleted"
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :gender,
      :email,
      :avatar
    )
  end

  def account_deactivation!
    if current_user.status_inactive?
      redirect_to account_deactivation_index_path, flash: { error: "You are taking a break from Tasktifier" }
    end
  end
end
