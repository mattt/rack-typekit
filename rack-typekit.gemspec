# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/typekit"

Gem::Specification.new do |s|
  s.name        = "rack-typekit"
  s.authors     = ["Mattt Thompson"]
  s.email       = "m@mattt.me"
  s.homepage    = "http://github.com/mattt/rack-typekit"
  s.version     = Rack::Typekit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "rack-typekit"
  s.description = "Rack middleware to automatically include your Typekit JavaScript files"

  s.add_runtime_dependency "rack", ">= 1.2.0", "<= 2.0.0"

  s.add_development_dependency "minitest",  "~> 2.11.4"
  s.add_development_dependency "rack-test", "~> 0.6.1"
  s.add_development_dependency "rake",      "~> 0.9.2"

  s.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
