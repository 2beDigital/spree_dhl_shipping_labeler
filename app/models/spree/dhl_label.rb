module Spree
  class DhlLabel < ActiveRecord::Base
    belongs_to :shipment    
    belongs_to :shipping_dhl_box, class_name: 'Spree::Shipping::DhlBox', foreign_key: 'spree_shipping_dhl_box_id'
    has_one :order, through: :shipment
    default_scope { order "created_at desc" }
    validates :tracker_code, presence: true 
    validates :label, presence: true

    def show_tracker_code
      self.tracker_code || 'No tracking number available'
    end

    def generate_label!
      _response, _request, message = get_response.generate_label!
      if message[:error].present?
        errors.add(:generate_label, message[:error])
      else
        self.response = _response
        self.request  = _request
        self.tracker_code = JSON.parse(response.body)['trackerCode']
        self.label = JSON.parse(response.body)['pdf']
      end
    end

    def get_response
      Spree::DhlShippingPackage.new(self)
    end

    def get_shipment_status   
      _response, message = SpreeDhlShippingLabeler::DhlTrackerTrace.shipment_status(self.tracker_code)
      if message[:error].present?
        errors.add(:shipment_status, message[:error])
      else
        return JSON.parse(_response.body,:symbolize_names => true)
      end
    end
  end
end
