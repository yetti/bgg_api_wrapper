# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true
  config.ignore_hosts "chromedriver.storage.googleapis.com"
end
