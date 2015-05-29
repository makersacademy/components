# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'makers_styles/version'

Gem::Specification.new do |spec|
  spec.name          = "makers_styles"
  spec.version       = MakersStyles::VERSION
  spec.authors       = ["Makers Academy Team"]
  spec.email         = ["dev@makersacademy.com"]
  spec.description   = %q{Makers styles}
  spec.summary       = %q{Central repo for Makers styles}
  spec.homepage      = "http://github.com/makersacademy/style_guide"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # TODO this should be split out into it's own gem
  spec.add_dependency "sinatra"
  spec.add_dependency "sinatra-contrib"
  spec.add_dependency "sinatra-partial"
  spec.add_dependency "sinatra-asset-pipeline"
  spec.add_dependency "sinatra-static-assets"
  spec.add_dependency "hashie"
  spec.add_dependency "uglifier"
  spec.add_dependency "sass"
  spec.add_dependency "tilt", ["~>1.4.1"]
  spec.add_development_dependency "middleman", ["~>3.3.12"]
  spec.add_development_dependency "middleman-livereload", ["~>3.1.0"]
  spec.add_development_dependency "middleman-gh-pages", ["~>0.0.3"]
  spec.add_development_dependency "compass", "~>1.0"
  spec.add_development_dependency "singularitygs", "~>1.4"
  spec.add_development_dependency "sass", "~>3.3"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
