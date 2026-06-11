# app/models/lead.rb
class Lead < ApplicationRecord
  # Tool runs the visitor generated before becoming a lead (valuation, comps,
  # buyer-map), linked at lead-creation time via the session. nullify so a
  # deleted lead leaves its (anonymous) runs intact.
  has_many :tool_runs, dependent: :nullify

  validates :first_name, :email, :company_name, presence: true

  enum :status, {
    new_lead: "new_lead",
    contacted: "contacted",
    qualified: "qualified",
    closed: "closed"
  }, default: "new_lead"
end