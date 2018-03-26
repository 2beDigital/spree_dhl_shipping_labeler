require 'spec_helper'

describe Spree::DhlLabel, :type => :model do
  let(:order) { create(:order_ready_to_ship) }
  let(:dhl_label) { described_class.new }
  let(:label) { order.shipments.first.build_dhl_label }

  it "is valid with valid attributes" do
    dhl_label.label = 'a_label_in_pdf_format'
    dhl_label.tracker_code = 'T1234565789'
    expect(dhl_label).to be_valid
  end

  it "is not valid without a label" do
    dhl_label.label = nil
    dhl_label.tracker_code = 'T1234565789'
    expect(dhl_label).to_not be_valid
  end

  it "is not valid without a tracker_code" do
    dhl_label.tracker_code = nil
    dhl_label.label = 'a_label_in_pdf_format'
    expect(dhl_label).to_not be_valid
  end

  describe "Associations" do
    it "has one shipment" do
      assc = described_class.reflect_on_association(:shipment)
      expect(assc.macro).to eq :belongs_to
    end

    it "has one order" do
      assc = described_class.reflect_on_association(:order)
      expect(assc.macro).to eq :has_one
    end
  end

  it "show_tracker_code not be empty" do
    expect(dhl_label.show_tracker_code).to_not be_empty
  end

  describe "Call to generate_label" do
    it "response must return Object => Net::HTTPOK" do  
      label.generate_label!    
      expect(label.response).to be_an_instance_of(Net::HTTPOK)
    end
    it "request must return  Object => Net::HTTP:Post" do
      label.generate_label!
      expect(label.request).to be_an_instance_of(Net::HTTP::Post)
    end
    it "tracker_code not be blank" do
      label.generate_label!
      expect(label.tracker_code).to be_an_instance_of(String)
    end
    it "label not be blank" do
      label.generate_label!
      expect(label.label).to be_an_instance_of(String)
    end
  end
end