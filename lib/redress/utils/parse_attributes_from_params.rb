# frozen_string_literal: true

require "redress/utils/attributes_hash"

module Redress
  module Utils
    class ParseAttributesFromParams
      def initialize(klass, params, options = nil)
        @klass = klass
        @params = convert_params_to_hash(params)
        @options = (options || {})
      end

      def attributes
        @attributes ||= extract_attributes
      end
      alias to_h attributes

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

      protected

      def extract_attributes
        hash = model_attributes.merge!(prefix_attibutes)
        AttributesHash.new(hash).extract!(*@klass.schema.keys)
      end

      def prefix_attibutes
        return {} if prefix.nil?

        hash = {}

        @params.each do |key, value|
          new_key = key.to_s
          next unless new_key.start_with?(prefix)

          new_key = new_key.dup if new_key.frozen?
          new_key.slice!(full_prefix)

          hash[new_key] = value
        end

        hash
      end

      def convert_params_to_hash(params)
        if params.respond_to?(:to_unsafe_h)
          params.to_unsafe_h
        else
          params
        end
      end
    end
  end
end
