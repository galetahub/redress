# frozen_string_literal: true

require 'wisper'

module Redress
  class Command
    include Wisper::Publisher

    def self.call(*args, &block)
      run(*args, &block)
      nil
    end

    def self.run(*args)
      command = new(*args)
      yield command if block_given?
      command.call
      command
    end
  end
end
