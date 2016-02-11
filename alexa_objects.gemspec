# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alexa_objects/version'

Gem::Specification.new do |spec|
  spec.name          = "alexa_objects"
  spec.version       = AlexaObjects::VERSION
  spec.authors       = ["Kyle Lucas"]
  spec.email         = ["kglucas93@gmail.com"]
  spec.summary       = %q{A pairing of objects for parsing Amazon Echo/Alexa skill requests.}
  spec.description   = %q{}
  spec.homepage      = "http://github.com/kylegrantlucas/alexa_objects"
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 1.9.3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sinatra"
  spec.add_development_dependency "webmock"

  spec.add_development_dependency "codeclimate-test-reporter"
end