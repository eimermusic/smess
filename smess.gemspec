$:.push File.expand_path("../lib", __FILE__)
require "smess/version"

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = "smess"
  s.version = Smess::VERSION
  s.date = Time.now
  s.summary = "A messy SMS messenger supporting every aggregator I have gotten my hands on"
  s.description = "A mess of SMS messaging"
  s.require_paths = ["lib"]
  s.author = "Martin Westin"
  s.email = "martin@eimermusic.com"
  s.homepage = "https://github.com/eimermusic/smess"
  s.license = 'MIT'

  s.add_development_dependency 'rspec', '>= 2.4.0'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'dotenv'
  s.add_dependency 'httpi', '~> 3.0'
  s.add_dependency 'clickatell', '~> 0'
  s.add_dependency 'activesupport', '>= 5.2.6', '< 7.1.0'
  s.add_dependency 'twilio-ruby', '~> 6.2'

  s.files = Dir["{lib}/**/*", "[A-Z]*", "init.rb"]
  s.required_ruby_version = ">= 2.0.0"
  s.required_rubygems_version = ">= 1.3.7"
end