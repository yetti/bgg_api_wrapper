# frozen_string_literal: true

require_relative "base_item"

module BggApiWrapper
  class BoardGame < BaseItem
    def initialize(data)
      super(data)

      @description = data.xpath("./description").text
      @thumbnail = data.xpath("./thumbnail").text
      @image = data.xpath("./image").text

      @min_players = data.xpath("./minplayers").text
      @max_players = data.xpath("./maxplayers").text

      @playing_time = data.xpath("./playingtime").text
      @min_play_time = data.xpath("./minplaytime").text
      @max_play_time = data.xpath("./maxplaytime").text

      @age = data.xpath("./age").text
    end
  end
end
