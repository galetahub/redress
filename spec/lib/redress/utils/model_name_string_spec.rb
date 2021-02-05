# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Redress::Utils::ModelNameString do
  let(:class_name) { 'SomeClassName' }
  let(:instance) { described_class.new(class_name) }

  it 'must convert to model name' do
    expect(instance.to_sym).to eq :some_class_name
  end
end
