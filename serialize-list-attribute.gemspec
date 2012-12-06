# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serialize-list-attribute/version'

Gem::Specification.new do |s|
  s.name          = 'serialize-list-attribute'
  s.version       = SerializeListAttribute::VERSION
  s.authors       = ['Alexander Kaupanin']
  s.email         = %w(kaupanin@gmail.com)
  s.description   = %q{Manage text field attribute serialized as an array, hash, etc. Add per-item validation}
  s.summary       = %q{Manage text field attribute serialized as an array, hash, etc. Add per-item validation}
  s.homepage      = 'http://github.com/simsalabim/serialize-list-attribute'

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = %w(lib)

  s.add_development_dependency 'rspec', '~> 2.9'
  s.add_development_dependency 'sqlite3'
  s.add_runtime_dependency     'activerecord', '~> 3.0'
end