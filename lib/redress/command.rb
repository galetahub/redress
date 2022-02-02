# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'dry/matcher/result_matcher'

module Redress
  class Command
    include Dry::Monads[:result]

    def self.call(*args, &block)
      result = new(*args).call
      return result unless block_given?

      Dry::Matcher::ResultMatcher.call(result, &block)
    end

    def self.run(*args, &block)
      command = new(*args)
      result = command.call
      return command unless block_given?

      Dry::Matcher::ResultMatcher.call(result, &block)

      command
    end

    def call
      raise NotImplementedError
    end
  end
end
