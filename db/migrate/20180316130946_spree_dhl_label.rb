class SpreeDhlLabel < ActiveRecord::Migration
    def change
	    create_table :spree_dhl_labels, :force => true do |t|
			t.belongs_to :order
			t.belongs_to :shipment  
			t.belongs_to :spree_shipping_dhl_box 
			t.text       :request,                 limit: 4294967295
			t.text       :response,                limit: 4294967295
			t.text       :label,                   limit: 4294967295
			t.string     :tracker_code
			t.string     :label_format
			t.boolean	 :return_label,			   default: false
			t.datetime   :created_at,              null: false
			t.datetime   :updated_at,              null: false
	    end

	    add_index :spree_dhl_labels, [:shipment_id], name: :idx_spree_dhl_shipping_labels
  	end
end