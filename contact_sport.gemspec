# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'contact_sport/version'

Gem::Specification.new do |gem|
  gem.name          = "contact_sport"
  gem.version       = ContactSport::VERSION
  gem.authors       = ["Andy Stewart"]
  gem.email         = ["boss@airbladesoftware.com"]
  gem.description   = 'Simple importing of contacts from Outlook and vCard.'
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'vcard', '~> 0.2'
  
  gem.add_development_dependency 'rake', '~> 0.9.2'
end
