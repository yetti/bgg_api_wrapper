# frozen_string_literal: true

module BggApiWrapper
  class SearchResult
    attr_reader :id, :title, :published

    def initialize(game)
      @id = game["objectid"]
      @title = game["name"]["__content__"] || game["name"]
      @published = game["yearpublished"] || "unknown"
    end

    def to_s
      "(#{id}) #{title} - #{published}"
    end
  end
end
