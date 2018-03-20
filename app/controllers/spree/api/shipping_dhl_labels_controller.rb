module Spree
  module Api
    class ShippingDhlLabelsController < Spree::Api::BaseController
      before_action :find_order
      before_action :find_shipment
      
      def generate_dhl_label        
        if @shipment.state != 'shipped'
          @label = @shipment.build_dhl_label
          @label.generate_label!  
          if @label.save
            flash[:success] = Spree.t(:label_success, number: @label.tracking_number)
          else
            flash[:error] = Spree.t(:label_error)        
          end
        else
          flash[:success] = Spree.t(:label_reload_success, number: @label.tracking_number)
        end
        redirect_to edit_admin_order_url(@order)
      end

      private

        def find_order
          @order = Spree::Order.where(number: params[:order_id]).first
        end

        def find_shipment
          @shipment = @order.shipments.find_by(number: params[:id])
        end

        def find_label
          @label = @shipment.dhl_label
        end
        
    end
  end
end