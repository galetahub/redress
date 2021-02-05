# frozen_string_literal: true

module Redress
  module Utils
    class ModelNameString
      attr_reader :original

      def initialize(original)
        @original = original.to_s
      end

      def to_sym
        underscore_original.to_sym
      end

      private

      def underscore_original
        if original.respond_to?(:underscore)
          original.underscore
        else
          underscore(original)
        end
      end

      # File activesupport/lib/active_support/inflector/methods.rb, line 92
      def underscore(camel_cased_word)
        return camel_cased_word unless /[A-Z-]|::/.match?(camel_cased_word)

        word = camel_cased_word.to_s.gsub('::', '/')
        word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
        word.tr!('-', '_')
        word.downcase!
        word
      end
    end
  end
end
