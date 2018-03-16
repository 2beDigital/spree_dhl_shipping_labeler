module Spree
  class DhlShippingPackage
    attr_reader :shipment, :order, :seur_label

    def initialize(label)
      @dhl_label = label
      @shipment  = @dhl_label.shipment
      @order     = @shipment.order
      self
    end

    def order_number
      order.number
    end

    def shipment_number
      shipment.number
    end

    def formatted_destination
      shipment.address.dhl_formatted(order.email)
    end

    def formatted_origin
      order.shipments.first.stock_location.dhl_formatted
    end

    def generate_label!
      labeler.generate_label
    end

    def labeler
      SpreeDhlShippingLabeler::DhlPickupLabel.new(self)
    end

  end
end