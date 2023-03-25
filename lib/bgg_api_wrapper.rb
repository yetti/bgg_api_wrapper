# frozen_string_literal: true

require "faraday"
require "faraday/retry"
require "faraday/xml"

require_relative "bgg_api_wrapper/version"
require_relative "bgg_api_wrapper/search_result"
require_relative "bgg_api_wrapper/board_game"

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
      response = make_request("/xmlapi/search", params)
      games = []
      if response.status == 200
        boardgames = normalize_results(response)

        boardgames.each do |game|
          games << SearchResult.new(game)
        end
      end
      games
    end

    def games(ids, opts = {})
      params = normalize_params(opts)

      game_ids = if ids.is_a? Array
        ids.join(",")
      else
        ids
      end

      response = make_request("/xmlapi/boardgame/#{game_ids}", params)
      games = []
      if response.status == 200
        boardgames = normalize_results(response)

        boardgames.each do |game|
          games << BoardGame.new(game)
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

    # For single results, API will not return an array, so we need to wrap
    # single result in an array before it gets mapped to the appropriate object.
    def normalize_results(response)
      boardgames = response.body["boardgames"]["boardgame"]
      unless boardgames.is_a?(Array)
        boardgames = [boardgames]
      end

      boardgames
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
        url: API_BASE_URL
      ) do |f|
        f.response :xml
        f.request :retry, retry_options
      end
    end
  end
end
