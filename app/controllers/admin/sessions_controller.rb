class Admin::SessionsController < Admin::BaseController
  skip_before_action :authenticate_admin, only: %i[new create]
  layout "admin_auth"

  # Throttle brute-force attempts on the login.
  rate_limit to: 10, within: 3.minutes, only: :create,
             by: -> { request.remote_ip },
             with: -> { redirect_to admin_login_path, alert: "Too many attempts. Please wait a moment and try again." }

  def new
    redirect_to(admin_leads_path) and return if session[:admin_authenticated]
  end

  def create
    if Admin::BaseController.valid_credentials?(params[:username], params[:password])
      session[:admin_authenticated] = true
      redirect_to(session.delete(:admin_return_to) || admin_leads_path, notice: "Signed in.")
    else
      flash.now[:alert] = "Incorrect username or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin_authenticated)
    redirect_to admin_login_path, notice: "Signed out."
  end
end
