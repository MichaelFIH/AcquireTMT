class DashboardsController < ApplicationController
  layout "dashboard"
  before_action :require_authentication

  # Single entry point that renders the buyer or seller dashboard by role.
  def show
    @user = Current.user
    if @user.buyer?
      return redirect_to onboarding_path unless @user.onboarded?
      @deals = Deal.for_buyer(@user)
      render :buyer
    else
      @tool_runs = @user.tool_runs.where(status: "complete").order(created_at: :desc)
      @advisor_lead = @user.leads.order(created_at: :desc).first
      # Derive the seller's sector from their most recent tool run so we can show
      # the acquirers actively buying businesses like theirs.
      @sector = @tool_runs.map { |r| r.result["industry"].presence || r.analysis["industry"].presence }.compact.first
      @potential_buyers = @sector ? Buyer.active.where("? = ANY (sectors)", @sector).order(acquisitions_count: :desc) : Buyer.none
      render :seller
    end
  end
end
