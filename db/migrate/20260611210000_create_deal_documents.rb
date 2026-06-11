class CreateDealDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :deal_documents do |t|
      t.references :deal, null: false, foreign_key: true
      t.string :title, null: false
      t.timestamps
    end
  end
end
