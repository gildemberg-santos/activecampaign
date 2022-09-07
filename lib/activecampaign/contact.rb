# frozen_string_literal: true

module Activecampaign
  class Contact
    def initialize(url:, token:)
      @url = Activecampaign.validade_uri("#{url}v3/contacts")
      @token = Activecampaign.validade_token(token)
    end

    def create(payload = nil)
      Activecampaign.validate_payload(payload)

      request = Activecampaign::Request.new(@url, @token)
      request.post(payload)
    end

    #
    #     def update(payload = nil)
    #       validate_payload(payload)
    #
    #       request = Activecampaign::Request.new(@url, @token)
    #       request.put(payload)
    #     end
    #
    #     def delete(payload = nil)
    #       validate_payload(payload)
    #
    #       request = Activecampaign::Request.new(@url, @token)
    #       request.delete(payload)
    #     end
    #
    #     def list
    #       request = Activecampaign::Request.new(@url, @token)
    #       request.get
    #     end
    #
  end
end
