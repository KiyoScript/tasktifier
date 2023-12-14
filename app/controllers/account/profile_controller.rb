class Account::ProfileController < ApplicationController
  before_action :authenticate_user!

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
end
