class AddShippingDhlBoxes < ActiveRecord::Migration
  def change
    create_table :spree_shipping_dhl_boxes, :force => true do |t|
      t.string   :description,       null: false
      t.integer  :minWeightKg,       null: false
      t.integer  :maxWeightKg,       null: false
      t.integer  :length,            null: false
      t.integer  :width,             null: false
      t.integer  :height,            null: false
      t.datetime :created_at,        null: false
      t.datetime :updated_at,        null: false
    end
    add_index :spree_shipping_dhl_boxes, [:description], :name => :idx_shipping_dhl_boxes_on_description, :unique => true
  end
end
