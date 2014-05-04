# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flocks/version'

Gem::Specification.new do |spec|
  spec.name          = "flocks"
  spec.version       = Flocks::VERSION
  spec.authors       = ["Adam Ryan"]
  spec.email         = ["adam.g.ryan@gmail.com"]
  spec.summary       = %q{Single node social relationships using redis.}
  spec.description   = %q{Single node social relationships using redis.}
  spec.homepage      = "https://github.com/byliner/flocks"
  spec.license       = "BSD"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "redis"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
