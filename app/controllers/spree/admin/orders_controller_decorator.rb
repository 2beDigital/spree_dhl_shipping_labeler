Spree::Admin::OrdersController.class_eval do
	include Spree::Admin::OrdersHelper
	before_action :load_order, only: [:show_shipment_state_dhl, :edit, :update, :cancel, :resume, :approve, :resend, :open_adjustments, :close_adjustments, :cart]
	respond_to :js, :only => [:show_shipment_state_dhl]
    ssl_allowed :show_shipment_state_dhl
	def show_shipment_state_dhl
		byebug
		if has_dhl_shipments?
		    @order.shipments.each do |shipment|
		      if shipment.dhl_label
		        @delivery = shipment.dhl_label.get_shipment_status
		        @error = shipment.dhl_label.errors.messages[:shipment_status].present? ? shipment.dhl_label.errors.messages[:shipment_status].first : nil
		      end
		    end
	    
			if @error
			    flash[:error] = Spree.t(:tracker_trace_error, error: @error)
			    render inline: "location.reload();" 
			    return
			end
		end
	end
end