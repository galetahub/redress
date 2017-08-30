# frozen_string_literal: true

require "spec_helper"

RSpec.describe Redress::Utils::BuildFormFromModel do
  let(:form_class) { SimpleForm }
  let(:model) { User.new(name: "Test", email: "test@example.com") }
  let(:builder) { described_class.new(form_class, model) }
  let(:instance) { builder.build }

  it "must be form class instance" do
    expect(instance.is_a?(form_class)).to be true
  end

  it "must copy attributes from model to form" do
    expect(instance.name).to eq model.name
    expect(instance.email).to eq model.email
  end

  it "must set dynamic attribute name_with_email" do
    expect(instance.name_with_email).to eq "#{model.name} <#{model.email}>"
  end
end
