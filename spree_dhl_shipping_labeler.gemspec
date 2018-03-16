# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spree_dhl_shipping_labeler/version'

Gem::Specification.new do |spec|
  spec.name          = "spree_dhl_shipping_labeler"
  spec.version       = SpreeDhlShippingLabeler::VERSION
  spec.authors       = ["Noel"]
  spec.email         = ["noel@2bedigital.com"]

  spec.summary       = %q{Dhl shipping labeler for spree e-commerce}
  spec.description   = %q{This gem let us generate labels for shippings and get status tracking of our shippings}
  spec.homepage      = "https://github.com/2beDigital/spree_dhl_shipping_labeler"

  spec.required_ruby_version = ">= 2.1"

  spec.files       = `git ls-files`.split("\n")
  spec.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'spree_core', '~> 2.4.10'
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end