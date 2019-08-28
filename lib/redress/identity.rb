# frozen_string_literal: true

module Redress
  # Gem identity information.
  module Identity
    def self.name
      'redress'
    end

    def self.label
      'Redress'
    end

    def self.version
      '0.4.2'
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end
