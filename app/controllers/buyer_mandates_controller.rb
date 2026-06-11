class BuyerMandatesController < ApplicationController
  before_action :require_authentication

  def update
    if Current.user.update(mandate_params)
      redirect_to dashboard_path, notice: "Your acquisition mandate has been saved."
    else
      redirect_to dashboard_path, alert: "We couldn't save your mandate."
    end
  end

  private

  def mandate_params
    params.require(:user).permit(
      :mandate_min_revenue, :mandate_max_revenue, :mandate_location,
      mandate_industries: []
    )
  end
end
