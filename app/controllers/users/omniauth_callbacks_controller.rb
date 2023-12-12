class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #before_action :set_account

  def google_oauth2
    @user = User.from_omniauth(auth_params)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = auth_params.except('extra') # Removing extra as it can overflow some session stores
      redirect_to new_user_session_path, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to user_session_path
  end

  private

  def auth_params
    request.env['omniauth.auth']
  end
end

