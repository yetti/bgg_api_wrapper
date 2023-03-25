# frozen_string_literal: true

RSpec.describe BggApiWrapper do
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
end
