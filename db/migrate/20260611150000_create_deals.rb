class CreateDeals < ActiveRecord::Migration[8.0]
  def change
    create_table :deals do |t|
      t.string  :reference, null: false           # e.g. "TMT-001"
      t.string  :title, null: false               # anonymized headline
      t.string  :industry, null: false            # sector slug
      t.bigint  :revenue
      t.bigint  :ebitda
      t.bigint  :asking_price
      t.string  :location
      t.text    :teaser
      t.string  :highlights, array: true, null: false, default: []
      t.boolean :recurring, null: false, default: false
      t.string  :status, null: false, default: "active"  # active | under_offer | sold

      t.timestamps
    end
    add_index :deals, :reference, unique: true
    add_index :deals, :industry
    add_index :deals, :status
  end
end
