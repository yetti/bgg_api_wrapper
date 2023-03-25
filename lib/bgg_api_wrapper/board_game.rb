# frozen_string_literal: true

require_relative "base_item"

module BggApiWrapper
  class BoardGame < BaseItem
    def initialize(data)
      super(data)

      @description = data["description"]
      @thumbnail = data["thumbnail"]
      @image = data["image"]

      @min_players = data["minplayers"]
      @max_players = data["maxplayers"]

      @playing_time = data["playingtime"]
      @min_play_time = data["minplaytime"]
      @max_play_time = data["maxplaytime"]

      @age = data["age"]
    end
  end
end
