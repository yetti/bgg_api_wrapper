# frozen_string_literal: true

require "nokogiri"

module BggApiWrapper
  class BaseItem
    attr_reader :id, :title, :published

    def initialize(data)
      @id = data.xpath("@objectid").text.to_i
      @title = data.xpath("./name[@primary=\"true\"]").text
      @published = data.xpath("./yearpublished").text

      # Sometimes there is only one title, so there won't be a "@primary" attribute.
      # In that case, just take the text of the "<name/>" node.
      if @title.empty?
        @title = data.xpath("./name").text
      end
    end

    def to_s
      "(#{id}) #{title} - #{published}"
    end
  end
end
