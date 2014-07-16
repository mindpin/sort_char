# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sort_char/version'

Gem::Specification.new do |spec|
  spec.name          = "sort_char"
  spec.version       = SortChar::VERSION
  spec.authors       = ["fushang318"]
  spec.email         = ["fushang318@gmail.com"]
  spec.description   = %q{sort_char}
  spec.summary       = %q{sort_char}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
