module SpreeDhlShippingLabeler
  class DhlTrackerTrace
    require 'net/http'
    require 'uri'

    def self.shipment_status(tracker_code)
      uri = URI.parse("https://api-gw-accept.dhlparcel.nl/track-trace?key=#{tracker_code}")
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/json"      
      req_options = { use_ssl: uri.scheme == "https" }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      			        http.request(request)
      			     end
      if response.code == '200' || response.code == '201'
        return [response, { :success => true }]
      else
        return [nil, { :error => response.code }]
      end
    end

  end
end
