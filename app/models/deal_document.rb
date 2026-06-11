# A document in a deal's data room (financials, CIM, etc.), shown to buyers
# who have approved access and have signed the NDA.
class DealDocument < ApplicationRecord
  belongs_to :deal
  has_one_attached :file

  validates :title, presence: true
  validate :file_attached

  private

  def file_attached
    errors.add(:file, "is required") unless file.attached?
  end
end
