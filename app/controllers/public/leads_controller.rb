class Public::LeadsController < ApplicationController
  def create
    @lead = Lead.new(lead_params)
    @lead.status ||= "new_lead"

    if @lead.save
      redirect_back fallback_location: root_path,
                    notice: "Thanks. Your request has been received."
    else
      redirect_back fallback_location: root_path,
                    alert: @lead.errors.full_messages.to_sentence
    end
  end

  private

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