# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new
    @user = User.new
  end


  def create
    self.resource = warden.authenticate(auth_options)

    if resource && resource.active_for_authentication?
        redirect_to root_path, flash: { success: "Successfully Signed in" }
    else
        redirect_to new_user_session_path, flash: { invalid_sign_in: "Invalid login credentials" }
    end
  end

  def destroy
    super
  end

  private

  def after_sign_out_path_for(resource)
    user_session_path
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
