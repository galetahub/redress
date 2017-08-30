# frozen_string_literal: true

require "fast_attributes"
require "hashie/mash"
require "active_model"

require "redress/utils/parse_attributes_from_params"
require "redress/utils/build_form_from_model"
require "redress/utils/attributes_builder"
require "redress/utils/attribute_set"

module Redress
  class Form
    extend FastAttributes
    include ActiveModel::Validations

    DEFAULT_NAME = "Form"
    SPLITTER = "::"

    attr_reader :context

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

    def self.schema(options = {}, &block)
      options = {
        initialize: true,
        attributes: true
      }.merge!(options)

      builder = Redress::Utils::AttributesBuilder.new(self, options)
      builder.instance_eval(&block)
      builder.compile!

      @raw_attributes = builder.attributes
    end

    def self.attribute_set
      @attribute_set ||= Redress::Utils::AttributeSet.new(@raw_attributes || [])
    end

    def to_model
      self
    end

    def to_param
      id.to_s
    end

    def with_context(options)
      @context = Hashie::Mash.new(options)
    end

    def properties
      @properties ||= attributes.with_indifferent_access
    end

    def map_model(model)
    end
  end
end
