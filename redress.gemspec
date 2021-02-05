# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'redress/identity'

Gem::Specification.new do |spec|
  spec.name = Redress::Identity.name
  spec.version = Redress::Identity.version
  spec.platform = Gem::Platform::RUBY
  spec.authors = ['Igor Galeta']
  spec.email = ['galeta.igor@gmail.com']
  spec.homepage = 'https://github.com/galetahub/redress'
  spec.summary = 'Build maintainable Ruby apps'
  spec.license = 'MIT'

  if File.exist?(Gem.default_key_path) && File.exist?(Gem.default_cert_path)
    spec.signing_key = Gem.default_key_path
    spec.cert_chain = [Gem.default_cert_path]
  end

  spec.required_ruby_version = '~> 2.5'

  spec.add_dependency 'dry-struct', '~> 1.0'
  spec.add_dependency 'dry-types', '~> 1.1'
  spec.add_dependency 'hashie', '>= 3.5.7'
  spec.add_dependency 'wisper', '>= 2.0.0'

  spec.add_development_dependency 'actionpack', '~> 5.2'
  spec.add_development_dependency 'activemodel', '>= 4.2.0'
  spec.add_development_dependency 'coveralls', '~> 0.8.21'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'
  spec.add_development_dependency 'pry-state', '~> 0.1'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'reek', '~> 4.7'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 0.49'

  spec.files = Dir['lib/**/*']
  spec.extra_rdoc_files = Dir['README*', 'LICENSE*']
  spec.require_paths = ['lib']
end
