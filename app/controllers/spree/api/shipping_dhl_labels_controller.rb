module Spree
  module Api
    class ShippingDhlLabelsController < Spree::Api::BaseController
      before_action :find_order
      before_action :find_shipment
      
      def generate_dhl_label        
        if @shipment.state != 'shipped'
          @label = @shipment.build_dhl_label(label_format: params[:label_format],spree_shipping_dhl_box_id: params[:spree_shipping_dhl_box_id])
          @label.generate_label!
          errors = @label.errors.messages[:generate_label].present? ? @label.errors.messages[:generate_label].first : nil
          if @label.save
            flash[:success] = Spree.t(:label_success, number: @label.tracker_code)
          else
            flash[:error] = Spree.t('generate_label_errors.code_' + errors)
          end
        else
          flash[:success] = Spree.t(:label_reload_success, number: @label.tracker_code)
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
    end
  end
end