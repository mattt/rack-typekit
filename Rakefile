require "bundler"
Bundler.setup

gemspec = eval(File.read("rack-typekit.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["rack-typekit.gemspec"] do
  system "gem build rack-typekit.gemspec"
  system "gem install rack-typekit-#{Rack::Typekit::VERSION}.gem"
end
