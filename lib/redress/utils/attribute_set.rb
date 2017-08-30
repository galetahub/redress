# frozen_string_literal: true

module Redress
  module Utils
    class AttributeSet
      include Enumerable

      class AttributeNode
        attr_reader :name, :type, :options

        def initialize(item)
          @name = Array(item[0])[0]
          @type = item[1]
          @options = item[2]
        end
      end

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
