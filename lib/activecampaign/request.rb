# frozen_string_literal: true

# active = Activecampaign::Request.new
# Activecampaign::Request.new.get
module Activecampaign
  class Request
    def initialize(url = nil, token = nil)
      uri(url)
      token(token)
      @response = nil
    end

    def post(payload = nil)
      validate_payload(payload)

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

    def validate_payload(payload = nil)
      return nil if payload.is_a?(NilClass)
      raise Activecampaign::InvalidPayloadError, "Payload must be a Hash '#{payload.class}'" unless payload.is_a?(Hash)
      raise Activecampaign::InvalidPayloadError, "Payload is required" if payload.blank?
    end

    def uri(url)
      raise Activecampaign::InvalidURIError, "Url is must be a String '#{url.class}'" unless url.is_a?(String)

      @url ||= URI.parse(url)
      raise Activecampaign::InvalidURIError, "Url is invalid '#{url}'" if @url.host.blank?
    rescue URI::InvalidURIError => error_uri
      raise Activecampaign::InvalidURIError, "Invalid URI '#{error_uri.message}'"
    end

    def token(token)
      raise Activecampaign::InvalidTokenError, "Token must be a String '#{token.class}'" unless token.is_a?(String)
      raise Activecampaign::InvalidTokenError, "Token is required" if token.blank?
      raise Activecampaign::InvalidTokenError, "Token is invalid '#{token}'" unless token.match?(/[A-Za-z0-9]{72}/)

      @token ||= token
    end
  end
end
