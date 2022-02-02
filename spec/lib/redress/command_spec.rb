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
      c.success { |value| total = value }
      c.failure { total = 0 }
    end

    expect(total).to eq a + b
    expect(result).to eq total
  end

  context 'when arguments are invalid' do
    let(:a) { nil }

    it 'must call failure callback' do
      total = 0

      result = SimpleCommand.call(a, b) do |c|
        c.success { |value| total = value }
        c.failure { total = 0 }
      end

      expect(total).to eq 0
      expect(result).to eq total
    end
  end

  context 'instance' do
    let(:command) { SimpleCommand.new(a, b) }

    it 'must call command' do
      command.call
      expect(command.value).to eq a + b
    end
  end
end
