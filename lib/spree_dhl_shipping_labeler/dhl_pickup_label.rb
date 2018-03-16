module SpreeDhlShippingLabeler
  class DhlPickupLabel
    require 'net/http'
    require 'uri'

    attr_reader :package, :access_token, :credentials, :customer, :shipper

    def initialize(pkg=nil)
      @package = pkg
      @customer = @package.formatted_destination
      @shipper = @package.formatted_origin
      @credentials = SpreeDhlShippingLabeler::DhlConection.credentials
      @access_token = get_access_token
    end

    def get_access_token
      uri = URI.parse('https://api-gw-accept.dhlparcel.nl/authenticate/api-key')
      request = Net::HTTP::Post.new(uri)
      request['accept'] = 'application/json'
      request.body = { userId: credentials[:userId], key: credentials[:key] }.to_json
      request.set_content_type('application/json')
      req_options = { use_ssl: true }
      response =  get_response(request)
      return JSON.parse(response.body)['accessToken']
    end

    def generate_label
      uri = URI.parse('https://api-gw-accept.dhlparcel.nl/labels')
      request = Net::HTTP::Post.new(uri)
      request['accept'] = 'application/json'
      request['Authorization'] = access_token
      request.set_content_type('application/json')
      req_options = { use_ssl: true }
      request.body = config_body_label
      response = get_response(request)
    end

    def get_response(request)
      Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end

    def config_body_label
      {
        labelId: SecureRandom.uuid,
        labelFormat: 'pdf',
        orderReference: 'myReference',
        parcelTypeKey: 'SMALL',
        receiver: {
          name: {
            firstName: customer[:firstName] ,
            lastName: customer[:lastName] ,
            companyName: customer[:companyName] || '' ,
            additionalName: customer[:name] || ''
          },
          address: {
            countryCode: customer[:countryCode],
            postalCode: customer[:postalCode],
            city: customer[:city],
            street: customer[:street],
            number: customer[:number],
            isBusiness: false,
            addition: 'A'
          },
          email: customer[:email],
          phoneNumber: customer[:phoneNumber]
        },
        shipper: {
          name: {
            firstName: shipper[:firstName],
            lastName: shipper[:lastName],
            companyName: shipper[:companyName],
            additionalName: shipper[:additionalName] || ''
          },
          address: {
            countryCode: shipper[:countryCode],
            postalCode: shipper[:postalCode],
            city: shipper[:city],
            street: shipper[:street],
            number: shipper[:number],
            isBusiness: true,
            addition: 'A'
          },
          email: shipper[:email],
          phoneNumber: shipper[:phoneNumber],
          vatNumber: shipper[:vatNumber]
        },
        accountId: credentials[accountId],
        options: [
          {
            key: 'DOOR'
          }
        ],
        returnLabel: false,
        pieceNumber: 1,
        quantity: 1,
        automaticPrintDialog: true,
        application: 'string',
        userId: credentials[:userId]
      }.to_json
    end 
  end
end