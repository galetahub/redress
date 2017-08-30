# frozen_string_literal: true

require "spec_helper"

RSpec.describe Redress::Utils::AttributeSet do
  let(:name) { :id }
  let(:type) { Integer }
  let(:raw_attributes) do
    [
      [name, type, nil],
      [[:title], String, required: true]
    ]
  end
  let(:set) { described_class.new(raw_attributes) }

  it "must read names" do
    expect(set.names).to eq [name, :title]
  end

  it "must iterate attributes" do
    set.each_with_index do |node, index|
      expect(node.type).to eq raw_attributes[index][1]
    end
  end
end
