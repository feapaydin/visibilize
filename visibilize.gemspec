lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'visibilize/version'

Gem::Specification.new do |spec|
  spec.name          = 'visibilize'
  spec.version       = Visibilize::VERSION
  spec.authors       = ['Furkan Enes Apaydın']
  spec.email         = ['feapaydin@gmail.com']

  spec.summary       = 'Generate random friendly identifiers for ActiveRecord instances.'
  spec.description   = 'Visibilize generates random friendly identifiers that can be exposed to end users for ActiveRecord models.'
  spec.homepage      = 'https://github.com/feapaydin/visibilize'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/feapaydin/visibilize'
  spec.metadata['changelog_uri'] = 'https://github.com/feapaydin/visibilize'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'activerecord', '~> 7.0'
  spec.add_development_dependency 'sqlite3', '~> 1.4'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
