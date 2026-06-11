class CreateBuyers < ActiveRecord::Migration[8.0]
  def change
    create_table :buyers do |t|
      t.string :name, null: false
      t.string :buyer_type, null: false             # pe_platform | strategic | search_fund | sba | aggregator
      t.string :backed_by
      t.text :thesis
      t.string :sectors, array: true, null: false, default: []  # applicable industry slugs
      t.bigint :min_revenue
      t.bigint :max_revenue
      t.integer :acquisitions_count, null: false, default: 0
      t.boolean :active, null: false, default: true
      t.string :source
      t.string :source_url

      t.timestamps
    end

    add_index :buyers, :sectors, using: :gin
    add_index :buyers, :buyer_type
  end
end
