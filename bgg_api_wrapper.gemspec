# frozen_string_literal: true

require_relative "lib/bgg_api_wrapper/version"

ruby_version = File.read(File.join(__dir__, ".ruby-version"))

Gem::Specification.new do |spec|
  spec.name = "bgg_api_wrapper"
  spec.version = BggApiWrapper::VERSION
  spec.authors = ["Yetrina Battad"]
  spec.email = ["hello@yetti.io"]

  spec.summary = "Wrapper around Board Game Geek API"
  spec.description = "Wrapper around the Board Game Geek XML API (v2)"
  spec.homepage = "https://github.com/yetti/bgg_api_wrapper"
  spec.license = "MIT"
  spec.required_ruby_version = ">= #{ruby_version}"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yetti/bgg_api_wrapper.git"
  spec.metadata["changelog_uri"] = "https://github.com/yetti/bgg_api_wrapper/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "rspec", "~> 3.0"

  spec.add_dependency "faraday", "~> 2.7"
  spec.add_dependency "faraday-retry", "~> 2.1"
  spec.add_dependency "nokogiri", "~> 1.14"

  spec.add_development_dependency "debug", ">= 1.0.0"

  spec.add_development_dependency "bundler-audit"

  spec.add_development_dependency "standard", "~> 1.0"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-rails"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rspec"

  spec.add_development_dependency "webmock", "~> 3.18"
  spec.add_development_dependency "vcr", "~> 6.1"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
