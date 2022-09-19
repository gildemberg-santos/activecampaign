# frozen_string_literal: true

module Activecampaign
  class Contact
    def initialize(url:, token:)
      @url = Activecampaign.validade_uri("#{url}api/3/contacts")
      @token = Activecampaign.validade_token(token)
      @contato = nil
    end

    def upset(payload = nil)
      Activecampaign.validate_payload(payload)
      payload = payload.deep_symbolize_keys

      if contact?(payload[:contact][:email])
        update(payload, find(payload[:contact][:email])[:id])
      else
        create(payload)
      end
    end

    def create(payload = nil)
      Activecampaign.validate_payload(payload)

      request = Activecampaign::Request.new(url: @url.to_s, token: @token)
      request.post(payload)
      request.json
    end

    def update(payload = nil, id = nil)
      Activecampaign.validate_payload(payload)

      request = Activecampaign::Request.new(url: "#{@url}/#{id}", token: @token)
      request.put(payload)
      request.json
    end

    def find(email)
      Activecampaign.validade_email(email)
      return @contato if @contato.present?

      request = Activecampaign::Request.new(url: "#{@url}?email=#{email}", token: @token)
      request.get
      @contato = request.json.deep_symbolize_keys[:contacts].first

      @contato
    end

    def contact?(email)
      find(email).present?
    end
  end
end
