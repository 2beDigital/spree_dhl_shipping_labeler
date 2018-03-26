require 'spec_helper'

describe Spree::OrdersHelper, :type => :helper do
	let(:order) { create(:order_ready_to_ship) }
	
	it "is not valid with default attributes" do
		@order = order
		expect(has_dhl_shipments?).to be false
	end

	it "is valid with correct attributes" do
		@order = order
		@order.shipments.first.shipping_method.update(name: 'DHL', admin_name: 'DHL')		
		expect(has_dhl_shipments?).to be true
	end
end