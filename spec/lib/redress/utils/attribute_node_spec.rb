# frozen_string_literal: true

require "spec_helper"

RSpec.describe Redress::Utils::AttributeNode do
  let(:name) { :id }
  let(:type) { Integer }
  let(:row) { [name, type, nil] }
  let(:node) { described_class.new(row) }

  it "must initialize node with attributes" do
    expect(node.name).to eq name
    expect(node.type).to eq type
    expect(node.options).to eq nil
  end

  context "row where name is array" do
    let(:row) { [[name], type, nil] }

    it "must initialize node with attributes" do
      expect(node.name).to eq name
      expect(node.type).to eq type
      expect(node.options).to eq nil
    end
  end
end
