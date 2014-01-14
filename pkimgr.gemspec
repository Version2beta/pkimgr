# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pkimgr/version'

Gem::Specification.new do |spec|
  spec.name          = "pkimgr"
  spec.version       = Pkimgr::VERSION
  spec.authors       = ["Rob Martin"]
  spec.email         = ["rob@version2beta.com"]
  spec.summary       = %q{Tools to manage a multi-level certificate authority}
  spec.description   = %q{Tools that create certificate authorities, host certificates, client certificates, and revocation lists.}
  spec.homepage      = ""
  spec.license       = "BSD"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "main"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard-minitest"
end
