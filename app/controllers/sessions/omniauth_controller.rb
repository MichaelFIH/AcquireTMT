class Sessions::OmniauthController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user&.persisted?
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to sign_in_path, alert: "We couldn't sign you in with Google."
    end
  end
end
