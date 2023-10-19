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

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_dependency 'dry-matcher'
  spec.add_dependency 'dry-monads', '>= 1.4.0'
  spec.add_dependency 'dry-struct', '>= 1.4.0'
  spec.add_dependency 'dry-types', '>= 1.5.0'
  spec.add_dependency 'hashie'

  spec.add_development_dependency 'actionpack', '~> 6.1'
  spec.add_development_dependency 'activemodel', '>= 4.2.0'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-state'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'

  spec.files = Dir['lib/**/*']
  spec.extra_rdoc_files = Dir['README*', 'LICENSE*']
  spec.require_paths = ['lib']
end
