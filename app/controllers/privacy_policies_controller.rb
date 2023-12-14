class PrivacyPoliciesController < ApplicationController
  def index
    redirect_to "https://www.privacypolicies.com/live/ec407071-bfc9-4e3e-b77e-27f1ac55cf8a", allow_other_host: true
  end
end
