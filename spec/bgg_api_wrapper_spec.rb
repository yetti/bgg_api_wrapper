# frozen_string_literal: true

RSpec.describe BggApiWrapper, :vcr do
  it "has a version number" do
    expect(BggApiWrapper::VERSION).not_to be_nil
  end

  describe "#search" do
    let(:results) { described_class.search("catan") }

    it "will have an ID" do
      results.each do |res|
        expect(res.id).not_to be_nil
      end
    end

    it "will have a title" do
      results.each do |res|
        expect(res.title).not_to be_nil
      end
    end

    it "will have a published date" do
      results.each do |res|
        expect(res.published).not_to be_nil
      end
    end

    it "will only have results with Catan in the title" do
      results.each do |res|
        expect(res.title.downcase).to include("catan")
      end
    end

    context "when exact search" do
      let(:results) { described_class.search("catan", true) }

      it "will have only a single result" do
        expect(results.length).to eq 1
      end
    end
  end

  describe "#games" do
    let(:results) { described_class.games("13") }

    it "will return a single game" do
      expect(results.length).to eq 1
    end

    it "will return the information for Catan" do
      game = results.first
      expect(game.id).to eq 13
    end

    context "when multiple IDs are provided as a string" do
      let(:results) { described_class.games("13,169786") }

      it "will return two games" do
        expect(results.length).to eq 2
      end

      it "will return the information for CATAN" do
        game = results.first
        expect(game.id).to eq 13
        expect(game.title).to eq "CATAN"
      end

      it "will return the information for Scythe" do
        game = results[1]
        expect(game.id).to eq 169786
        expect(game.title).to eq "Scythe"
      end
    end
  end
end
