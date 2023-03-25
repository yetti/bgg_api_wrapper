# frozen_string_literal: true

require_relative "../../spec_helper"

require "bgg_api_wrapper/search_result"

RSpec.describe BggApiWrapper::SearchResult do
  subject(:result) { described_class.new(game_hash) }

  let(:game_hash) do
    {
      "objectid" => 123,
      "name" => "Board Game",
      "yearpublished" => "2020"
    }
  end

  describe "#to_s" do
    context "when published date is nil" do
      let(:game_hash) do
        {
          "objectid" => 123,
          "name" => "Board Game",
          "yearpublished" => nil
        }
      end

      it "returns 'unknown' as the published date" do
        expect(result.to_s).to include("unknown")
      end
    end
  end
end
