# frozen_string_literal: true

require 'dry-types'

module Redress
  module Types
    include Dry::Types()

    StrippedString = String.constructor do |value|
      value.to_s.strip.empty? ? nil : value.to_s.strip
    end
  end
end
