module Spree
  class DhlLabel < ActiveRecord::Base
    belongs_to :shipment    
    has_one :order, through: :shipment
    default_scope { order "created_at desc" }
    validates :tracker_code, presence: true 
    validates :label, presence: true

    def show_tracker_code
      self.tracker_code || 'No tracking number available'
    end

    def generate_label!
      _response, _request = get_response.generate_label!
      self.response = _response
      self.request  = _request
      self.tracker_code = JSON.parse(response.body)['trackerCode']
      self.label = JSON.parse(response.body)['pdf']
    end

    def get_response
      Spree::DhlShippingPackage.new(self)
    end
  end
end
