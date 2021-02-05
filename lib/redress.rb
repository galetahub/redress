# frozen_string_literal: true

require 'redress/identity'

module Redress
end

require 'redress/types'
require 'redress/form'
require 'redress/command'

if defined?(ActiveModel)
  require 'redress/hooks/active_model'
  Redress::Form.include(Redress::Hooks::ActiveModel)
end
