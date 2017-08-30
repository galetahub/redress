# frozen_string_literal: true

require "redress/utils/attribute_node"

module Redress
  module Utils
    class AttributeSet
      include Enumerable

      def initialize(raw_attributes)
        @raw_attributes = Array(raw_attributes)

        @attributes = @raw_attributes.map { |item| AttributeNode.new(item) }
      end

      def each(&block)
        @attributes.each(&block)
      end

      def names
        @names ||= map(&:name)
      end
    end
  end
end
