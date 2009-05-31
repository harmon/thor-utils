# coding: utf-8

begin
  require "rubygems/specification"
rescue SecurityError
  # http://gems.github.com
end

VERSION  = "0.0.1"
SPECIFICATION = ::Gem::Specification.new do |s|
  s.name = "thor-utils"
  s.version = VERSION
  s.authors = ["Jakub Šťastný aka Botanicus"]
  s.homepage = "http://github.com/botanicus/thor-utils"
  s.summary = "Thor extensions"
  s.description = "" # TODO: long description
  s.cert_chain = nil
  s.email = ["knava.bestvinensis", "gmail.com"].join("@")
  s.files = Dir.glob("**/*") - Dir.glob("pkg/*")
  s.add_dependency "thor"
  s.require_paths = ["lib"]
  # s.required_ruby_version = ::Gem::Requirement.new(">= 1.9.1")
end
