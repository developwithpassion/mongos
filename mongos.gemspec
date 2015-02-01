# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib",__FILE__)
require "mongos/version"

Gem::Specification.new do |s|
  s.name        = "mongos"
  s.version     = Mongos::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.authors     = ["Develop With Passion®"]
  s.email       = ["open_source@developwithpassion.com"]
  s.homepage    = "http://www.developwithpassion.com"
  s.summary     = %q{Basic wrapper module for mongo access}
  s.description = %q{Simple mongo wrapper}
  s.rubyforge_project = "mongos"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency('configatron', "~> 4.2.0")
  s.add_runtime_dependency('mongo', "~> 1.11.1")
  s.add_runtime_dependency('bson_ext', "~> 1.11.1")
end
