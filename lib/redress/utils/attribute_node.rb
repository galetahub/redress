# frozen_string_literal: true

module Redress
  module Utils
    class AttributeNode
      attr_reader :name, :type, :options

      def initialize(item)
        @name = Array(item[0])[0]
        @type = item[1]
        @options = item[2]
      end
    end
  end
end
