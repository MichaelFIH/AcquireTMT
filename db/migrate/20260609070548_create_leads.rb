class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :company_name
      t.string :company_website
      t.string :company_type
      t.string :revenue_range
      t.string :ebitda_range
      t.string :source
      t.text :message
      t.string :status

      t.timestamps
    end
  end
end
