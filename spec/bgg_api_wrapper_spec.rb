# frozen_string_literal: true

RSpec.describe BggApiWrapper do
  it "has a version number" do
    expect(BggApiWrapper::VERSION).not_to be_nil
  end
end
