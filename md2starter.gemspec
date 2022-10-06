# frozen_string_literal: true
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "lib/md2starter/version"

Gem::Specification.new do |spec|
  spec.name = "md2starter"
  spec.version = Md2starter::VERSION
  spec.authors = ["Atelier Mirai"]
  spec.email = ["contact@atelier-mirai.net"]
  spec.summary = "A converter from Markdown to Re:VIEW Starter."
  spec.description = "A converter from Markdown to Re:VIEW Starter. It uses redcarpet."
  spec.homepage = "https://github.com/Atelier-Mirai/md2starter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Atelier-Mirai/md2starter"
  spec.metadata["changelog_uri"] = "https://github.com/Atelier-Mirai/md2starter/blob/master/CHANGELOG.md"

  spec.files = `git ls-files -- lib/* bin/* README.md`.split("\n")
  spec.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "redcarpet"
  # spec.add_development_dependency "minitest"
  # spec.add_development_dependency "rake"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
