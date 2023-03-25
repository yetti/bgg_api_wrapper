# frozen_string_literal: true

require "faraday"
require "faraday/retry"
require "faraday/decode_xml"
require "ostruct"

require_relative "bgg_api_wrapper/version"
require_relative "bgg_api_wrapper/search_result"

module BggApiWrapper
  class Error < StandardError; end

  MAX_ATTEMPTS = 3
  API_BASE_URL = "https://boardgamegeek.com"

  class << self
    def search(query, exact = false)
      params = {search: query}
      if exact
        params[:exact] = 1
      end
      result = make_request("/xmlapi/search", params)
      games = []
      if result.status == 200
        if exact
          games << SearchResult.new(result.body["boardgames"]["boardgame"])
        else
          result.body["boardgames"]["boardgame"].each do |b|
            games << SearchResult.new(b)
          end
        end
      end
      games
    end

    private

    def normalize_params(params)
      params.each do |key, value|
        if value
          params[key] = 1
        else
          params.delete key
        end
      end
    end

    def make_request(path, params)
      @connection ||= setup_connection
      @connection.get(path, params)
    end

    def setup_connection
      retry_options ||= {
        max: MAX_ATTEMPTS,
        interval: 0.05,
        interval_randomness: 0.5,
        backoff_factor: 2
      }

      Faraday.new(
        url: API_BASE_URL,
        headers: {"Content-Type" => "application/xml"}
      ) do |f|
        f.response :xml
        f.request :retry, retry_options
      end
    end
  end
end
