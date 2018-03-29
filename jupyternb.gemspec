# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/version'

Gem::Specification.new do |spec|
  spec.name          = "jupyternb"
  spec.version       = JupyterNB::VERSION
  spec.authors       = ["Hermann Detz"]
  spec.email         = ["hermann.detz@gmail.com"]
  spec.description   = <<-EOF 
                       This gem provides useful functions to work with
											 Jupyter Notebook files.
                       EOF
  spec.summary       = %q{Jupyter Notebook Tools}
  spec.homepage      = "https://github.com/hermanndetz/jupyternb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end

