# frozen_string_literal: true

require "spec_helper"

RSpec.describe Redress::Utils::ParseAttributesFromParams do
  let(:form_class) { SimpleForm }
  let(:options) { {} }
  let(:parser) { described_class.new(form_class, params, options) }

  context "group" do
    let(:user) { {name: "test", email: "test@example.com", id: 1} }
    let(:params) { {user: user} }

    it "parser without prefix" do
      expect(parser.prefix).to eq nil
    end

    it "must parse model_attributes" do
      expect(parser.model_attributes).to eq user
    end

    it "must parse attributes" do
      expect(parser.attributes[:name]).to eq user[:name]
      expect(parser.attributes[:email]).to eq user[:email]
      expect(parser.attributes[:id]).to eq nil
    end
  end

  context "prefix" do
    let(:options) { {prefix: "user"} }
    let(:params) { {user_name: "Test", user_email: "test@example.com", id: 1} }

    it "parser with prefix" do
      expect(parser.prefix).to eq "user"
    end

    it "must parse model_attributes" do
      expect(parser.model_attributes).to be_empty
    end

    it "must parse prefix_attibutes" do
      hash = parser.send(:prefix_attibutes)

      expect(hash["name"]).to eq params[:user_name]
      expect(hash["email"]).to eq params[:user_email]
    end

    it "must parse attributes" do
      expect(parser.attributes[:name]).to eq params[:user_name]
      expect(parser.attributes[:email]).to eq params[:user_email]

      expect(parser.attributes["name"]).to eq params[:user_name]
      expect(parser.attributes["email"]).to eq params[:user_email]

      expect(parser.attributes[:id]).to eq nil
      expect(parser.attributes["id"]).to eq nil
    end

    context "frozen" do
      let(:key) { "user_name" }
      let(:params) { {key => "Test", user_email: "test@example.com", id: 1}.freeze }

      it "must parse attibutes" do
        expect(parser.attributes[:name]).to eq params[key]
        expect(parser.attributes[:email]).to eq params[:user_email]
      end
    end
  end
end
