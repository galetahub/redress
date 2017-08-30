# frozen_string_literal: true

require "fast_attributes"

module Redress
  module Utils
    class AttributesBuilder < FastAttributes::Builder
      attr_reader :attributes

      def compile!
        super
        self
      end
    end
  end
end
