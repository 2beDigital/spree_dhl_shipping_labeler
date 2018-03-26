module SpreeDhlShippingLabeler
  class DhlPickupLabel
    require 'net/http'
    require 'uri'

    attr_reader :package, :credentials, :customer, :shipper

    def initialize(pkg=nil)
      @package = pkg
      @customer = @package.formatted_destination
      @shipper = @package.formatted_origin
      @credentials = SpreeDhlShippingLabeler::DhlConection.credentials
    end

    def get_access_token
      uri = URI.parse('https://api-gw-accept.dhlparcel.nl/authenticate/api-key')
      request = Net::HTTP::Post.new(uri)
      request['accept'] = 'application/json'
      request.body = { userId: credentials[:userId], key: credentials[:key] }.to_json
      request.content_type = 'application/json'
      response =  get_response(request, uri)
      return (response.code == '200' || response.code == '201') ? JSON.parse(response.body)['accessToken'] : response.code
    end

    def generate_label
      uri = URI.parse('https://api-gw-accept.dhlparcel.nl/labels')
      request = Net::HTTP::Post.new(uri)
      request['Accept'] = 'application/json'
      request['Authorization'] = "Bearer " + get_access_token
      request.content_type = 'application/json'
      request.body = config_body_label
      response = get_response(request, uri)
      if response.code == '200' || response.code == '201'
        return [response, request, { :success => true }]
      else
        return [nil, nil, { :error => response.code }]
      end
    end

    def get_response(request, uri)
      req_options = {
        use_ssl: uri.scheme == "https",
      }
      Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end

    def config_body_label
      {
        labelId: SecureRandom.uuid,
        labelFormat: 'pdf',
        orderReference: package.order_number,
        orderId:        package.order_number,
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
            number: customer[:number] || '',
            isBusiness: false
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
            number: shipper[:number] || '',
            isBusiness: true
          },
          email: shipper[:email],
          phoneNumber: shipper[:phoneNumber],
          vatNumber: shipper[:vatNumber]
        },
        accountId: credentials[:accountId],
        options: [ # Preguntar por las opciones
          { key: 'DOOR' },
          { key: 'REFERENCE', input: 'text1234' },
          { key: 'INS'      , input: 12.34 },
          { key: 'COD_CASH' , input: 56.78 }
        ],
        isReturnShipment: false,
        pieceNumber: 1,
        quantity: 1,
        application: 'string',
        userId: credentials[:userId]
      }.to_json
    end 
  end
end