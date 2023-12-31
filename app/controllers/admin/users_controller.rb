class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  include AdminAccessible

  before_action :set_user, only: %i[show update destroy]

 def index
  @filtered_users = User.ransack(params[:q])
  @pagy, @users = pagy(@filtered_users.result.order(:created_at => :desc), items: 10)
 end


 def show; end

 def update
  respond_to do |format|
    if @user.update(user_params)
      flash_message = { success: "User updated successfully" }
    else
      flash_message = { error: @user.errors.full_messages.first }
    end
    format.turbo_stream { redirect_back fallback_location: admin_users_path, flash: flash_message }
  end
 end

 def destroy
  respond_to do |format|
  if @user.destroy
    flash_message = { success: "User deleted successfully" }
  else
    flash_message = { error: @user.errors.full_messages.first }
  end
    format.turbo_stream { redirect_back fallback_location: admin_users_path, flash: flash_message }
  end
end

private
  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,
      :gender,
      :email,
      :avatar,
      :role
    )
  end
end
