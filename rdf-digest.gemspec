# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.version               = File.read('VERSION').chomp
  gem.date                  = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name                  = "rdf-digest"
  gem.homepage              = "http://github.com/barmintor/rdf-digest"
  gem.license               = 'Unlicense'
  gem.summary               = "Graph hashing algortihms for Ruby."
  gem.description           = %q{RDF::Digest contains graph hashing algortihms for the RDF.rb library suite.}

  gem.authors               = ['Benjamin Armintor']

  gem.platform              = Gem::Platform::RUBY
  gem.files                 = %w(README.md History UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.require_paths         = %w(lib)
  gem.extensions            = %w()
  gem.test_files            = %w()
  gem.has_rdoc              = false

  gem.required_ruby_version = '>= 2.2.2'
  gem.requirements          = []
  gem.add_runtime_dependency     'rdf',             '~> 3.0'
  gem.add_development_dependency 'rspec',           '~> 3.7'
  gem.add_development_dependency 'rdf-turtle',       '~> 3.0'
  gem.add_development_dependency 'rdf-vocab',       '~> 3.0'

  gem.add_development_dependency 'rake',            '~> 12.0'
  gem.post_install_message  = nil
end