# frozen_string_literal: true

require 'hashie'

module Redress
  module Utils
    class AttributesHash < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::IndifferentAccess
    end
  end
end
