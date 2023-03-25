# frozen_string_literal: true

require_relative "base_item"

module BggApiWrapper
  class SearchResult < BaseItem
    def initialize(data)
      super(data)

      if @published.empty?
        @published = "unknown"
      end
    end
  end
end
