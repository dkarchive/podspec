# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'podspec/version'

Gem::Specification.new do |spec|
  spec.name          = Podspec::PRODUCT
  spec.version       = Podspec::VERSION
  spec.authors       = ["dkhamsing"]
  spec.email         = ["dkhamsing8@gmail.com"]

  spec.summary       = 'Effortlessly create a CocoaPods Podspec.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/dkhamsing/podspec'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = [Podspec::PRODUCT]
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'octokit', '~> 4.2.0' # github
  spec.add_dependency 'netrc', '~> 0.11.0'          # credentials
end
