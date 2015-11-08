# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'work_guide/version'

Gem::Specification.new do |spec|
  spec.name          = "work_guide"
  spec.version       = WorkGuide::VERSION
  spec.authors       = ["adorechic"]
  spec.email         = ["adorechic@gmail.com"]

  spec.summary       = %q{CLI tool to listup routine tasks}
  spec.description   = %q{WorkGuide is a CLI tool to manage your routine tasks}
  spec.homepage      = "https://github.com/adorechic/work_guide"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "activesupport"
  spec.add_dependency "kosi"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "fakefs"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "timecop"
end
