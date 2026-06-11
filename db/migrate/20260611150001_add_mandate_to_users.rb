class AddMandateToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :mandate_industries, :string, array: true, null: false, default: []
    add_column :users, :mandate_min_revenue, :bigint
    add_column :users, :mandate_max_revenue, :bigint
    add_column :users, :mandate_location, :string
  end
end
