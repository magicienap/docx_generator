# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docx_generator/version'

Gem::Specification.new do |spec|
  spec.name          = "docx_generator"
  spec.version       = DocxGenerator::VERSION
  spec.authors       = ["Antoine Proulx"]
  spec.email         = ["proulx.antoine@gmail.com"]
  spec.description   = %q{A gem to generate docx files.}
  spec.summary       = %q{A gem to generate docx files.}
  spec.homepage      = "http://github.com/magicienap/docx_generator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_runtime_dependency "zipruby"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "libnotify"
end
