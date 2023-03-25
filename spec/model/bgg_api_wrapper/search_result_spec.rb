# frozen_string_literal: true

require_relative "../../spec_helper"

require "bgg_api_wrapper/search_result"

RSpec.describe BggApiWrapper::SearchResult do
  subject(:result) do
    doc = Nokogiri::XML(game_xml)
    described_class.new(doc.xpath(".//boardgames/boardgame"))
  end

  let(:game_xml) do
    <<~GAMEXML
      <boardgames termsofuse="https://boardgamegeek.com/xmlapi/termsofuse">
        <boardgame objectid="110308">
          <name primary="true">7 Wonders: Catan</name>
          <yearpublished>2011</yearpublished>
        </boardgame>
      </boardgames>
    GAMEXML
  end

  describe "#to_s" do
    context "when published date is nil" do
      let(:game_xml) do
        <<~GAMEXML
          <boardgames termsofuse="https://boardgamegeek.com/xmlapi/termsofuse">
            <boardgame objectid="110308">
              <name primary="true">7 Wonders: Catan</name>
            </boardgame>
          </boardgames>
        GAMEXML
      end

      it "returns 'unknown' as the published date" do
        expect(result.to_s).to include("unknown")
      end
    end
  end
end
