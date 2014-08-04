# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'svn_parallel/version'

Gem::Specification.new do |spec|
  spec.name          = "svn_parallel"
  spec.version       = SvnParallel::VERSION
  spec.authors       = ["tleish"]
  spec.email         = ["tleish@gmail.com"]
  spec.summary       = %q{Faster svn up when using svn externals.}
  spec.description   = %q{If you have an app in subversion with many externals, it may take a bit too long to update it, as updates happen one after another. This gem updates the root and each external in parallel, making it much faster.}
  spec.homepage      = "http://github.com/tleish"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 0"
end
