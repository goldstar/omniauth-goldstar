# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-goldstar/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-goldstar"
  s.version     = OmniAuth::Goldstar::VERSION
  s.authors     = ["Robert Graff"]
  s.email       = [""]
  s.homepage    = "https://github.com/goldstar/omniauth-goldstar"
  s.description = %q{OmniAuth strategy for Goldstar}
  s.summary     = s.description
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'json', '~> 1.8'
  s.add_dependency 'omniauth-oauth2', '~> 1.5'

  s.add_development_dependency "pry"
  s.add_development_dependency "bundler", "1.17.3"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rspec_junit_formatter"
end
