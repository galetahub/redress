# frozen_string_literal: true

require "spec_helper"

RSpec.describe Redress::Form do
  let(:params) { {name: "test", email: "test@example.com", id: 1} }
  let(:form) { SimpleForm.from_params(user: params) }

  it "must get model_name" do
    expect(SimpleForm.model_name.is_a?(ActiveModel::Name)).to eq true
  end

  it "must get mimicked_model_name" do
    expect(SimpleForm.mimicked_model_name).to eq :user
  end

  it "must get infer_model_name" do
    expect(SimpleForm.infer_model_name).to eq :simple
  end

  it "must get attribute_set" do
    set = SimpleForm.attribute_set
    expect(set.names).to eq [:name, :email, :name_with_email]
  end

  it "must read properties" do
    expect(form.properties[:name]).to eq params[:name]
    expect(form.properties[:email]).to eq params[:email]

    expect(form.properties[:name_with_email]).to eq nil
    expect(form.properties[:id]).to eq nil

    expect(form.properties.key?(:name_with_email)).to eq true
    expect(form.properties.key?(:id)).to eq false
  end
end
