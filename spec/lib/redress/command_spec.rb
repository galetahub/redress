# frozen_string_literal: true

require "spec_helper"

RSpec.describe Redress::Command do
  class SimpleCommand < described_class
    attr_reader :value

    def initialize(a, b)
      @a = a
      @b = b
    end

    def call
      @value = @a + @b

      broadcast(:ok, @value)
    end
  end

  let(:a) { 1 }
  let(:b) { 2 }
  let(:command) { SimpleCommand.new(a, b) }

  it "must run command" do
    command = SimpleCommand.run(a, b)
    expect(command.value).to eq a + b
  end

  it "must call command" do
    command.call
    expect(command.value).to eq a + b
  end
end
