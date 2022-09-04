# frozen_string_literal: true

# active = Activecampaign::Request.new
# Activecampaign::Request.new.get
module Activecampaign
  class Request
    attr_writer :access_token

    def initialize(url = nil)
      url = URL
      raise Activecampaign::InvalidURIError, "URL is required" if url.blank?

      @url = URI.parse(url)
      @access_token = TOKEN
      @response = nil
    end

    def post(payload = nil)
    end

    def get
      @response = execute_request(:get)
      return json if status_code == 200

      raise Bitrix24::Error, json["error_description"]
    end

    def json
      JSON.parse(@response.body)
    end

    def status_code
      @response.code.to_i
    end

    private

    def requisition_settings(method = :post)
      request = Kernel.const_get("Net::HTTP::#{method.to_s.capitalize}").new(@url.request_uri)
      request["Content-Type"] = "application/json"
      request["Accept"] = "application/json"
      request["Api-Token"] = @access_token
      request
    end

    def execute_request(method = :post)
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.request(requisition_settings(method))
    end
  end
end
