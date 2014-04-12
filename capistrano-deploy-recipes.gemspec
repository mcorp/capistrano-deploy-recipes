# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "capistrano-deploy-recipes"
  gem.version       = '0.1.6.rc'
  gem.authors       = ["Adilson Carvalho"]
  gem.email         = ["lc.adilson@gmail.com"]
  gem.description   = %q{Capistrano fullstack deploy recipes}
  gem.summary       = %q{Capistrano fullstack deploy recipes}
  gem.homepage      = "https://github.com/mcorp/capistrano-deploy-recipes"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano', '~> 3.1'
  gem.add_dependency 'capistrano-bundler', '~> 1.1'

  gem.add_development_dependency 'rspec', '~> 2.14'
  gem.add_development_dependency 'guard-rspec', '~> 4.2'
  gem.add_development_dependency 'fuubar'
end
