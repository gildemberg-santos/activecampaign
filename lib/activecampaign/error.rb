# frozen_string_literal: true

module Activecampaign
  class Error < StandardError; end
  class InvalidURIError < StandardError; end
  class JsonParseError < StandardError; end
  class InvalidPayloadError < StandardError; end
  class InvalidTokenError < StandardError; end
end
