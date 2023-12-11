class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #before_action :set_account

  def google_oauth2
    @google_connect = GoogleConnect.process_response(auth_params, current_user.id)

    if @google_connect[:success]
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'

      redirect_to root_path, notice: "Signed in successfully."
    else
      session['devise.google_auth2_data'] = auth_params.except('extra')

      redirect_to user_session_path, alert: @google_connect.errors.full_messages.join('\n')
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

