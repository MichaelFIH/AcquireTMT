class Public::LeadsController < ApplicationController
  def create
    @lead = Lead.new(lead_params)
    @lead.status ||= "new_lead"
    resume_session # public controller; attach the lead to a logged-in seller
    @lead.user = Current.user if Current.user

    if @lead.save
      attach_tool_runs(@lead)
      redirect_back fallback_location: root_path,
                    notice: "Thanks. Your request has been received."
    else
      redirect_back fallback_location: root_path,
                    alert: @lead.errors.full_messages.to_sentence
    end
  end

  private

  # Link any tool runs this visitor generated in their session (see
  # Public::ToolsController#track_tool_run) to the lead they just became, so an
  # advisor sees the valuation / comps / buyers that brought them in.
  def attach_tool_runs(lead)
    ids = Array(session[:tool_run_ids])
    return if ids.empty?

    ToolRun.where(id: ids, lead_id: nil).update_all(lead_id: lead.id, updated_at: Time.current)
    session.delete(:tool_run_ids)
  end

  def lead_params
    params.require(:lead).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :company_name,
      :company_website,
      :company_type,
      :revenue_range,
      :ebitda_range,
      :source,
      :message
    )
  end
end