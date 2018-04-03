namespace :shipping_dhl_boxes do
  	desc "Create shipping dhl boxes"
	task create: :environment do
	  	puts "Create shipping dhl boxes"

		# DHL Shipping boxes for Spain business destination not business DHL-PARCEL. Consult other configurations.
		shipping_boxes =[
		  {
		    "key": "SMALL",
		    "minWeightKg": 0,
		    "maxWeightKg": 5,
		    "dimensions": {
		      "maxLengthCm": 25,
		      "maxWidthCm": 20,
		      "maxHeightCm": 5
		    }
		  },
		  {
		    "key": "MEDIUM",
		    "minWeightKg": 5,
		    "maxWeightKg": 15,
		    "dimensions": {
		      "maxLengthCm": 60,
		      "maxWidthCm": 50,
		      "maxHeightCm": 25
		    }
		  },
		  {
		    "key": "LARGE",
		    "minWeightKg": 16,
		    "maxWeightKg": 31,
		    "dimensions": {
		      "maxLengthCm": 120,
		      "maxWidthCm": 60,
		      "maxHeightCm": 60
		    }
		  },
		  {
		    "key": "BULKY",
		    "minWeightKg": 0,
		    "maxWeightKg": 31,
		    "dimensions": {
		      "maxLengthCm": 200,
		      "maxWidthCm": 120,
		      "maxHeightCm": 80
		    }
		  }
		]

		shipping_boxes.each do |shipping_box|
		  box = Spree::Shipping::DhlBox.where(
		    description: shipping_box[:key],
		    minWeightKg: shipping_box[:minWeightKg],
		    maxWeightKg: shipping_box[:maxWeightKg],
		    length: shipping_box[:dimensions][:maxLengthCm],
		    width:  shipping_box[:dimensions][:maxWidthCm],
		    height: shipping_box[:dimensions][:maxHeightCm]).first_or_create!

		  puts "Ensured existence of shipping box #{box.description}"
		end
	end
end