# frozen_string_literal: true

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
      raise Activecampaign::Error, "Error: #{error}. StatusCode: #{status_code}" unless [201].include?(status_code)

      @response
    end

    def put(payload = nil)
      Activecampaign.validate_payload(payload)
      @response = execute_request(method: :put, payload: payload)
      raise Activecampaign::Error, "Error: #{error}. StatusCode: #{status_code}" unless [200].include?(status_code)

      @response
    end

    def get
      @response = execute_request(method: :get)
      raise Activecampaign::Error, "Error: #{error} StatusCode: #{status_code}" unless [200].include?(status_code)

      @response
    end

    def body
      @response.read_body
    end

    def error
      json["errors"].map { |error| error["title"] }.join(", ")
    rescue StandardError
      "undefined error"
    end

    def json
      JSON.parse(@response.read_body)
    rescue JSON::ParserError => error_json
      raise Activecampaign::JsonParseError, "Invalid JSON response #{error_json.message}"
    end

    def status_code
      @response.code.to_i
    end

    private

    def requisition_settings(method: :post, payload: nil)
      request = Kernel.const_get("Net::HTTP::#{method.to_s.capitalize}").new(@url.request_uri)
      request["Content-Type"] = "application/json"
      request["Accept"] = "application/json"
      request["Api-Token"] = @token
      request.body = payload.to_json unless payload.nil?
      request
    end

    def execute_request(method: :post, payload: nil)
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http_request = requisition_settings(method: method, payload: payload)
      http.request(http_request)
    end
  end
end
