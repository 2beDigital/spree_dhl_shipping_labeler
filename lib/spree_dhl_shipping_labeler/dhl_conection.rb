require 'spree_dhl_shipping_labeler/dhl_helper'

module SpreeDhlShippingLabeler
  class DhlConection
    include DhlHelper
    attr_accessor :params

    def self.config params
      requires!(params, :userId,
                        :key,
                        :accountId)
      @params = params
    end

    def self.connection_params
      raise "SpreeDhlShippingLabeler not configured!" if @params.nil?
      @params
    end

    def self.credentials
      connection_params
    end

    private

    def self.requires!(hash, *params)
      params.each { |param| raise RateError, "Missing Required Parameter #{param}" if hash[param].nil? }
    end

  end
end
