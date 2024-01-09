class AccountDeactivationController < ApplicationController
  before_action :authenticate_user!
  before_action :account_deactivation!
  def index;end

  private
  def account_deactivation!
    unless current_user.status_inactive?
      redirect_to root_path, flash: { error: "You are not authorized to access this page" }
    end
  end
end
