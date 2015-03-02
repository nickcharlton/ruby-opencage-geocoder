lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_cage/version'

Gem::Specification.new do |s|
  s.name        = 'open_cage-geocoder'
  s.version     = OpenCage::VERSION
  s.licenses    = ['MIT']
  s.summary     = 'A client for the OpenCage Data geocoder API'
  s.description = 'A client for the OpenCage Data geocoder API'
  s.authors     = ['Samuel Scully']
  s.email       = 'dev@lokku.com'
  s.homepage    = 'https://github.com/lokku/ruby-opencage-geocoder'

  s.files    = `git ls-files -z`.split("\x0").reject do |f|
    f.match(/^(test|spec|features)\//)
  end
  s.require_paths = ['lib']

  s.add_development_dependency 'minitest', '~> 5.5'
end
