# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scoped_id/version'

Gem::Specification.new do |spec|
  spec.name          = "scoped_id"
  spec.version       = ScopedId::VERSION
  spec.authors       = ["Michel Billard"]
  spec.email         = ["michel@mbillard.com"]
  spec.summary       = "Generates scoped unique identifiers"
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://github.com/mbillard/scoped_id"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord', '>= 4.0.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
end
