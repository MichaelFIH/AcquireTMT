class DealsController < ApplicationController
  before_action :require_authentication
  before_action :set_deal

  def show
  end

  # A buyer asks to see the full deal. Captured as a lead for the advisor team.
  def request_access
    Lead.create(
      first_name: Current.user.display_name,
      email: Current.user.email_address,
      company_name: "Buyer — #{Current.user.display_name}",
      source: "deal_inquiry",
      message: "Access requested for #{@deal.reference} — #{@deal.title}"
    )
    redirect_to deal_path(@deal), notice: "Access requested — our team will follow up by email."
  end

  private

  def set_deal
    @deal = Deal.find(params[:id])
  end
end
