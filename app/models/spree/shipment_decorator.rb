Spree::Shipment.class_eval do
  has_one :dhl_label, class_name: "Spree::DhlLabel"
end