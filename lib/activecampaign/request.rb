# frozen_string_literal: true

# active = Activecampaign::Request.new
# Activecampaign::Request.new.get
module Activecampaign
  class Request
    def initialize(url:, token:)
      @url = Activecampaign.validade_uri(url)
      @token = Activecampaign.validade_token(token)
      @response = nil
    end

    def post(payload = nil)
      Activecampaign.validate_payload(payload)

      @response = execute_request(method: :post, payload: payload)
      return json if status_code == 200

      raise Activecampaign::Error, json["error_description"]
    end

    def get
      @response = execute_request(method: :get)
      return json if status_code == 200

      raise Activecampaign::Error, json["error_description"]
    end

    def json
      JSON.parse(@response.body)
    rescue JSON::ParserError => error_json
      raise Activecampaign::JsonParseError, "Invalid JSON response #{error_json.message}"
    end

    def status_code
      @response.code.to_i
    end

    private

    def requisition_settings(method: :post, payload: nil)
      request = Kernel.const_get("Net::HTTP::#{method.to_s.capitalize}").new(@url.request_uri)
      request.merge!({ "Content-Type" => "application/json", "Accept" => "application/json", "Api-Token" => @token })
      request.body = payload.to_json unless payload.nil?
      request
    end

    def execute_request(method: :post, payload: nil)
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = requisition_settings(method: method, payload: payload)
      http.request(request)
    end
  end
end
