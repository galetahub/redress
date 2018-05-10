# frozen_string_literal: true

module Redress
  module Utils
    class BuildFormFromModel
      def initialize(form_class, model)
        @form_class = form_class
        @model = model
      end

      def build
        form.map_model(@model)
        form
      end

      private

      def form
        @form ||= @form_class.new(model_attributes)
      end

      def model_attributes
        matching_attributes.each_with_object({}) do |name, hash|
          value = @model.public_send(name)
          next if value.nil?

          hash[name] = value
        end
      end

      def matching_attributes
        @form_class.attribute_names.select { |name| @model.respond_to?(name) }
      end
    end
  end
end
