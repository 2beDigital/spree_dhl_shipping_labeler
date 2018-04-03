module Spree
  module Shipping
    class DhlBox < ActiveRecord::Base
      self.table_name = "spree_shipping_dhl_boxes"
      validates_uniqueness_of :description, case_sensitive: false
    end
  end
end