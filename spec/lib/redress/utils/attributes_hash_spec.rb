# frozen_string_literal: true

require "spec_helper"

RSpec.describe Redress::Utils::AttributesHash do
  let(:hash) { {name: "Test", email: "test@example.com"} }
  let(:node) { described_class.new(hash) }

  it "must read attributes via symbol key" do
    expect(node[:name]).to eq hash[:name]
    expect(node[:email]).to eq hash[:email]
  end

  it "must read attributes via string key" do
    expect(node["name"]).to eq hash[:name]
    expect(node["email"]).to eq hash[:email]
  end
end
