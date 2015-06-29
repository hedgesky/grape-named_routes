lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape/named_routes/version'

Gem::Specification.new do |spec|
  spec.name          = 'grape-named_routes'
  spec.version       = Grape::NamedRoutes::VERSION
  spec.authors       = ['Anton Chuchkalov']
  spec.email         = ['a2new@yandex.ru']

  spec.summary       = %q{Add support for named routes in grape.}
  spec.description   = %q{This implementation is really simple and not very dynamic, but may be handy.}
  spec.homepage      = 'https://github.com/hedgesky/grape-named_routes'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'grape', '>= 0.11'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
