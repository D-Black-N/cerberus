# frozen_string_literal: true

require_relative "lib/cerberus/version"

Gem::Specification.new do |spec|
  spec.name          = "cerberus"
  spec.version       = Cerberus::VERSION
  spec.authors       = ["Danil Nasibullin"]
  spec.email         = ["dan.nasibullin@gmail.com"]

  spec.summary       = "High-performance ABAC (Attribute-Based Access Control) engine for Ruby"
  spec.description   = "Cerberus is a policy evaluation engine implementing ABAC/XACML-like authorization model for Ruby, Rails and Hanami applications."
  spec.homepage      = "https://github.com/D-Black-N/cerberus"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.1"

  spec.metadata = {
    "homepage_uri"        => spec.homepage,
    "source_code_uri"    => spec.homepage,
    "changelog_uri"      => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "bug_tracker_uri"    => "#{spec.homepage}/issues",
    "allowed_push_host"  => "https://rubygems.org",
    "rubygems_mfa_required" => "true"
  }

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
