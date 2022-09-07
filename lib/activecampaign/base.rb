# frozen_string_literal: true

module Activecampaign
  def self.validate_payload(payload = nil)
    return nil if payload.is_a?(NilClass)

    raise Activecampaign::InvalidPayloadError, "Payload must be a Hash '#{payload.class}'" unless payload.is_a?(Hash)
    raise Activecampaign::InvalidPayloadError, "Payload is required" if payload.blank?

    payload
  end

  def self.validade_uri(url)
    raise Activecampaign::InvalidURIError, "Url is must be a String '#{url.class}'" unless url.is_a?(String)

    uri ||= URI.parse(url)
    raise Activecampaign::InvalidURIError, "Url is invalid '#{url}'" if uri.host.blank?

    uri
  rescue URI::InvalidURIError => error_uri
    raise Activecampaign::InvalidURIError, error_uri.message
  end

  def self.validade_token(token)
    raise Activecampaign::InvalidTokenError, "Token must be a String '#{token.class}'" unless token.is_a?(String)
    raise Activecampaign::InvalidTokenError, "Token is required" if token.blank?
    raise Activecampaign::InvalidTokenError, "Token is invalid '#{token}'" unless token.match?(/[A-Za-z0-9]{72}/)

    token
  end
end
