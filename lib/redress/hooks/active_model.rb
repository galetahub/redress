# frozen_string_literal: true

require 'active_model'

module Redress
  module Hooks
    module ActiveModel
      def self.included(base)
        base.extend(ClassMethods)
        base.include(::ActiveModel::Validations)
        base.include(::ActiveModel::Conversion)
      end

      module ClassMethods
        def model_name
          ::ActiveModel::Name.new(self, nil, mimicked_model_name.to_s.camelize)
        end
      end
    end
  end
end
