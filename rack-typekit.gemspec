require File.expand_path("../lib/rack/typekit", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rack-typekit"
  s.authors     = ["Mattt Thompson"]
  s.email       = "m@mattt.me"
  s.homepage    = "http://github.com/mattt/rack-typekit"
  s.version     = Rack::Typekit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "rack-typekit"
  s.description = "Rack middleware to automatically include your Typekit JavaScript files"
  
  s.required_rubygems_version = ">= 1.3.6"
  
  s.files         = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md", "*.rdoc"]
  s.require_path  = 'lib'
end