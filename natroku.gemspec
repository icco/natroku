# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'natroku/version'

Gem::Specification.new do |spec|
  spec.name          = "natroku"
  spec.version       = Natroku::VERSION
  spec.authors       = ["Nat Welch"]
  spec.email         = ["nat@natwelch.com"]
  spec.summary       = %q{Dumb people hosting.}
  spec.description   = %q{
Natroku, is what I like to call "dumb people hosting". Not because because it is stupid simple or because you'd have to be dumb to use it. But rather it is a hosting tool that explicitly throws away most of the common sense behind good hosting. There is no replication. There are no backups. There is no monitoring.
  }
  spec.homepage      = "https://github.com/icco/natroku/"
  spec.license       = "GPLv3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["natroku"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "fog"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
