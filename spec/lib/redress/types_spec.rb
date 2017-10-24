# frozen_string_literal: true

require "spec_helper"

RSpec.describe Redress::Types do
  it "must be a module" do
    expect(described_class.is_a?(Module)).to eq true
  end
end
