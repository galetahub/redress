# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Redress::Command do
  let(:a) { 1 }
  let(:b) { 2 }

  it 'must run command' do
    command = SimpleCommand.run(a, b)

    expect(command).not_to be nil
    expect(command.value).to eq a + b
  end

  it 'must call command with callbacks' do
    total = 0

    result = SimpleCommand.call(a, b) do |c|
      c.on(:ok) { |value| total = value }
    end

    expect(total).to eq a + b
    expect(result).to eq nil
  end

  context 'instance' do
    let(:command) { SimpleCommand.new(a, b) }

    it 'must call command' do
      command.call
      expect(command.value).to eq a + b
    end
  end
end
