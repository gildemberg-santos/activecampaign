module Activecampaign
  class Deal
    def initialize(url:, token:)
      @url = Activecampaign.validade_uri("#{url}api/3/deals")
      @token = Activecampaign.validade_token(token)
    end

    # def create(payload = nil)
    #   Activecampaign.validate_payload(payload)

    #   request = Activecampaign::Request.new(url: @url.to_s, token: @token)
    #   request.post(payload)
    #   request.json
    # end

    # def update(payload = nil, id = nil)
    #   Activecampaign.validate_payload(payload)

    #   request = Activecampaign::Request.new(url: "#{@url}/#{id}", token: @token)
    #   request.put(payload)
    #   request.json
    # end

    # def find(title)
    #   Activecampaign.validade_email(title)
    #   return @deal if @deal.present?

    #   request = Activecampaign::Request.new(url: "#{@url}?search=#{title}", token: @token)
    #   request.get
    #   @deal = request.json.deep_symbolize_keys[:deals].first

    #   @deal
    # end

    # def deal?(title)
    #   find(title).present?
    # end
  end
end
