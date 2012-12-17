# -*- encoding: utf-8 -*-
require File.expand_path('../lib/counter_cachier/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tom Caspy"]
  gem.email         = ["tcaspy@gmail.com"]
  gem.description   = %q{Counter cache on steroids - requires a bit of configuration, but then simply saves counter data.}
  gem.summary       = %q{simply set the counter's name and write a block for recalculation of that cache, and you're done}
  gem.homepage      = "https://github.com/unorthodoxgeek/counter-cachier"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "visit-counter"
  gem.require_paths = ["lib"]
  gem.version       = CounterCachier::VERSION
  
  gem.add_development_dependency(%q<rspec>, [">= 0"])
  gem.add_development_dependency(%q<rake>, ["~> 0.9.2"])
  gem.add_dependency(%q<redis>, [">= 0"])
end
