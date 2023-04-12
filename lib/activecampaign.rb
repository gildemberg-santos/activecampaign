# frozen_string_literal: true

require "uri"
require "json"
require "net/http"
require "openssl"
require "active_support/time"
require "logger"

module Activecampaign; end

require "activecampaign/version"
require "activecampaign/error"
require "activecampaign/base"
require "activecampaign/request"
require "activecampaign/contact"
