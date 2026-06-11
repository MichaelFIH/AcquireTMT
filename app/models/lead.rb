# app/models/lead.rb
class Lead < ApplicationRecord
  # Tool runs the visitor generated before becoming a lead (valuation, comps,
  # buyer-map), linked at lead-creation time via the session. nullify so a
  # deleted lead leaves its (anonymous) runs intact.
  has_many :tool_runs, dependent: :nullify
  belongs_to :user, optional: true

  validates :first_name, :email, :company_name, presence: true

  # Human-facing advisor stage shown on the seller dashboard.
  STATUS_LABELS = {
    "new_lead" => "Request received", "contacted" => "Advisor reached out",
    "qualified" => "In discussion", "closed" => "Engagement closed"
  }.freeze

  def status_label
    STATUS_LABELS[status] || status&.humanize
  end

  enum :status, {
    new_lead: "new_lead",
    contacted: "contacted",
    qualified: "qualified",
    closed: "closed"
  }, default: "new_lead"
end