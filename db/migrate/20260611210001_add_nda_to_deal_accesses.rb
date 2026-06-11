class AddNdaToDealAccesses < ActiveRecord::Migration[8.0]
  def change
    add_column :deal_accesses, :nda_signed_at, :datetime
  end
end
