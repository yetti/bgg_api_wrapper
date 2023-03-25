# frozen_string_literal: true

module BggApiWrapper
  class BaseItem
    attr_reader :id, :title, :published

    def initialize(data)
      @id = data["objectid"].to_i
      @title = data["name"]
      @published = data["yearpublished"]
    end

    def to_s
      "(#{id}) #{title} - #{published}"
    end
  end
end
