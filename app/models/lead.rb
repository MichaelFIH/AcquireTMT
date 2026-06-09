# app/models/lead.rb
class Lead < ApplicationRecord
  validates :first_name, :email, :company_name, presence: true

  enum :status, {
    new_lead: "new_lead",
    contacted: "contacted",
    qualified: "qualified",
    closed: "closed"
  }, default: "new_lead"
end