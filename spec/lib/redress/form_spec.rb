# frozen_string_literal: true

require "spec_helper"

RSpec.describe Redress::Form do
  let(:params) { {name: "test", email: "test@example.com", id: 1, age: "30"} }
  let(:form) { SimpleForm.from_params(user: params) }
  let(:model) { User.new(name: "Test", email: "test@example.com") }

  it "must get model_name" do
    expect(SimpleForm.model_name.is_a?(ActiveModel::Name)).to eq true
  end

  it "must get mimicked_model_name" do
    expect(SimpleForm.mimicked_model_name).to eq :user
  end

  it "must get infer_model_name" do
    expect(SimpleForm.infer_model_name).to eq :simple
  end

  it "must get schema" do
    schema = SimpleForm.schema
    expect(schema.keys).to eq %i[nickname name email name_with_email age]
  end

  it "must coercion age value" do
    expect(form.age).to eq 30
  end

  it "must coercion dynamic age value" do
    form.age = ""
    expect(form.age).to eq nil

    form.age = "20"
    expect(form.age).to eq 20
  end

  it "must read properties" do
    expect(form.properties[:name]).to eq params[:name]
    expect(form.properties[:email]).to eq params[:email]

    expect(form.properties[:name_with_email]).to eq nil
    expect(form.properties[:id]).to eq nil

    expect(form.properties.key?(:name_with_email)).to eq true
    expect(form.properties.key?(:id)).to eq false
  end

  it "must set context" do
    form.with_context(user: model)

    expect(form.context.user).to eq model
  end

  it "without context" do
    expect(form.context).to eq nil
  end

  it "must build form from model" do
    form = SimpleForm.from_model(model)

    expect(form.name).to eq model.name
    expect(form.email).to eq model.email
    expect(form.name_with_email).to eq "#{model.name} <#{model.email}>"
  end
end
