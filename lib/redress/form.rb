# frozen_string_literal: true

require 'hashie/mash'
require 'active_model'
require 'dry-struct'

require 'redress/utils/parse_attributes_from_params'
require 'redress/utils/build_form_from_model'
require 'redress/utils/attributes_hash'

module Redress
  class Form < Dry::Struct
    include ActiveModel::Validations
    include ActiveModel::Conversion

    DEFAULT_NAME = 'Form'
    SPLITTER = '::'

    attr_reader :context

    transform_keys(&:to_sym)
    transform_types(&:omittable)

    def self.model_name
      ActiveModel::Name.new(self, nil, mimicked_model_name.to_s.camelize)
    end

    def self.mimic(model_name)
      @model_name = model_name.to_s.underscore.to_sym
    end

    def self.mimicked_model_name
      @model_name || infer_model_name
    end

    def self.infer_model_name
      class_name = name.split(SPLITTER).last
      return :form if class_name == DEFAULT_NAME

      class_name.chomp(DEFAULT_NAME).underscore.to_sym
    end

    def self.from_params(params, options = nil)
      new(Redress::Utils::ParseAttributesFromParams.new(self, params, options).to_h)
    end

    def self.from_model(model)
      Redress::Utils::BuildFormFromModel.new(self, model).build
    end

    def self.define_schema(options = nil)
      options.each { |key, value| public_send(key, value) } if options

      yield

      attribute_names.each do |name|
        method_name = :"#{name}="
        next if instance_methods.include?(method_name)

        define_method(method_name) do |value|
          write_attribute(name, value)
        end
      end
    end

    def persisted?
      respond_to?(:id) && id.present?
    end

    def with_context(options)
      @context = Hashie::Mash.new(options)
      self
    end

    def properties
      @properties ||= Redress::Utils::AttributesHash.new(to_hash)
    end

    def map_model(model)
    end

    protected

    def write_attribute(name, value)
      return unless self.class.has_attribute?(name)

      @attributes[name] = safe_coercion(name, value)
    end

    private

    def safe_coercion(name, value)
      type = self.class.schema.key(name)
      type[value]
    rescue Dry::Types::CoercionError
      nil
    end
  end
end
