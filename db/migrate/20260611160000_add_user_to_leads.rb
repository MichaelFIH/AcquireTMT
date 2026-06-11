class AddUserToLeads < ActiveRecord::Migration[8.0]
  def change
    add_reference :leads, :user, foreign_key: true, null: true
  end
end
