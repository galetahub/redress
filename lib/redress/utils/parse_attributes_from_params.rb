# frozen_string_literal: true

module Redress
  module Utils
    class ParseAttributesFromParams
      def initialize(klass, params, options = nil)
        @klass = klass
        @params = params
        @options = (options || {})
      end

      def attributes
        model_attributes.merge!(prefix_attibutes)
                        .with_indifferent_access
                        .extract!(*@klass.attribute_set.names)
      end

      def model_attributes
        @params.fetch(@klass.mimicked_model_name, {})
      end

      def prefix
        return if @options[:prefix].blank?
        @prefix ||= @options[:prefix].to_s
      end

      def full_prefix
        @full_prefix ||= "#{prefix}_"
      end

      def to_h
        attributes
      end

      protected

      def prefix_attibutes
        return {} if prefix.nil?

        hash = {}

        @params.each do |key, value|
          next unless key.to_s.start_with?(prefix)
          hash[key.to_s.delete(full_prefix)] = value
        end

        hash
      end
    end
  end
end
