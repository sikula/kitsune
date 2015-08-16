$:.push File.expand_path("../lib", __FILE__)
require "kitsune/version"

Gem::Specification.new do |s|
  s.name		= "kitsune"
  s.version		= Kitsune::VERSION
  s.platform		= Gem::Platform::RUBY
  s.executables 	<< "kitsune"
  
s.authors		= ["Peter Vicherek"]
  s.summary		= %q{An application fingerprinting tool based on system artifact analysis}
  s.description		= %q{Discovers applications and versions deployed on a system}
  s.email		= ""
  s.homepage		= ""

  s.license		= "MIT"
  
  s.files		= %x{git ls-files}.split("\n")
  s.require_paths	= ["lib"]
end
