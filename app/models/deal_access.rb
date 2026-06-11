# A buyer's request to access a deal's data room. Admins approve or decline;
# only approved buyers see the full deal materials.
class DealAccess < ApplicationRecord
  belongs_to :user
  belongs_to :deal

  STATUSES = %w[requested approved declined].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :user_id, uniqueness: { scope: :deal_id }

  scope :requested, -> { where(status: "requested") }
  scope :approved, -> { where(status: "approved") }

  def approved?
    status == "approved"
  end

  def nda_signed?
    nda_signed_at.present?
  end

  # The data room opens only once access is approved AND the NDA is signed.
  def unlocked?
    approved? && nda_signed?
  end
end
