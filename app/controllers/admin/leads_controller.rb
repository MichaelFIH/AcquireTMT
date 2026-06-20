class Admin::LeadsController < Admin::BaseController
  # Source values grouped into the filter tabs on the leads index.
  SOURCE_GROUPS = {
    "sellers" => %w[get_started_seller],
    "tools"   => %w[valuation_snapshot market_comps buyer_map],
    "contact" => %w[contact deal_inquiry buyer_network]
  }.freeze

  def index
    @filter = params[:filter].presence_in(SOURCE_GROUPS.keys)
    @leads = Lead.includes(:tool_runs).order(created_at: :desc)
    @leads = @leads.where(source: SOURCE_GROUPS[@filter]) if @filter
    @source_counts = Lead.group(:source).count
  end

  def show
    @lead = Lead.find(params[:id])
  end

  def update
    @lead = Lead.find(params[:id])

    if @lead.update(lead_params)
      redirect_to admin_lead_path(@lead), notice: "Lead updated."
    else
      redirect_to admin_lead_path(@lead), alert: @lead.errors.full_messages.to_sentence
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:status)
  end
end
