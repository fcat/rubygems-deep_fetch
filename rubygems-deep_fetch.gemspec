# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.name          = "rubygems-deep_fetch"
  gem.version       = "0.1.0"

  gem.authors       = ["Fabien Catteau"]
  gem.email         = ["fabien.catteau@mingalar.fr"]
  gem.homepage      = "https://github.com/fcat/rubygems-deep_fetch"
  gem.summary       = %q{Fetch a gem along with its dependencies}
  gem.description   = <<desc
  The `gem deep_fetch` command works like `gem fetch`
  but it downloads all the gems required to satisfy the dependencies
  except the ones already available (ie in the cache).
desc

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_rubygems_version = '>= 2.0.0'
end
