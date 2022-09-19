module Activecampaign
  class Tag
    def initialize(url:, token:)
      @url = Activecampaign.validade_uri("#{url}api/3/tags")
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

    # def find(name)
    #   Activecampaign.validade_email(name)
    #   return @tag if @tag.present?

    #   request = Activecampaign::Request.new(url: "#{@url}?search=#{name}", token: @token)
    #   request.get
    #   @tag = request.json.deep_symbolize_keys[:tags].first

    #   @tag
    # end

    # def tag?(name)
    #   find(name).present?
    # end
  end
end
