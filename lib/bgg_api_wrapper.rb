# frozen_string_literal: true

require "faraday"
require "faraday/retry"
require "nokogiri"

require_relative "bgg_api_wrapper/version"

module BggApiWrapper
  class Error < StandardError; end

  MAX_ATTEMPTS = 3
  API_BASE_URL = "https://boardgamegeek.com/xmlapi"
end
