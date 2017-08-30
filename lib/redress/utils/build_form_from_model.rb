# frozen_string_literal: true

module Redress
  module Utils
    class BuildFormFromModel
      def initialize(form_class, model)
        @form_class = form_class
        @model = model
      end

      def build
        form.tap do
          matching_attributes.each do |name, _|
            model_value = @model.public_send(name)
            form.public_send("#{name}=", model_value)
          end

          form.map_model(@model)
        end
      end

      private

      def form
        @form ||= @form_class.new
      end

      def matching_attributes
        form.attributes.select { |name, _| @model.respond_to?(name) }
      end
    end
  end
end
