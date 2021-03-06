# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Redress::Form do
  let(:params) { {name: 'test', email: 'test@example.com', id: 1, age: '30'} }
  let(:form) { SimpleForm.from_params(user: params) }
  let(:model) { User.new(name: 'Test', email: 'test@example.com') }
  let(:comment) { CommentForm.new(content: 'test', id: 1) }

  it 'must get model_name' do
    expect(SimpleForm.model_name.is_a?(ActiveModel::Name)).to eq true
  end

  it 'must get mimicked_model_name' do
    expect(SimpleForm.mimicked_model_name).to eq :user
  end

  it 'must get infer_model_name' do
    expect(SimpleForm.infer_model_name).to eq :simple
  end

  it 'must get schema' do
    schema = SimpleForm.schema
    expect(schema.keys.map(&:name)).to eq %i[nickname name email name_with_email age bio]
  end

  it 'must coercion age value' do
    expect(form.age).to eq 30
  end

  it 'must return nil for bio when empty' do
    form.bio = ' '
    expect(form.bio).to eq nil
  end

  it 'must return nil for bio when blank' do
    form.bio = ''
    expect(form.bio).to eq nil
  end

  it 'must return nil for nil' do
    form.bio = nil
    expect(form.bio).to eq nil
  end

  it 'must strip bio value' do
    form.bio = ' test '
    expect(form.bio).to eq 'test'
  end

  it 'must coercion dynamic age value' do
    form.age = ''
    expect(form.age).to eq nil

    form.age = '20'
    expect(form.age).to eq 20
  end

  it 'must read properties' do
    expect(form.properties[:name]).to eq params[:name]
    expect(form.properties[:email]).to eq params[:email]

    expect(form.properties[:name_with_email]).to eq nil
    expect(form.properties[:id]).to eq nil

    expect(form.properties.key?(:name_with_email)).to eq false
    expect(form.properties.key?(:id)).to eq false
  end

  it 'must set context' do
    form.with_context(user: model)

    expect(form.context.user).to eq model
  end

  it 'without context' do
    expect(form.context).to eq nil
  end

  it 'must build form from model' do
    form = SimpleForm.from_model(model)

    expect(form.name).to eq model.name
    expect(form.email).to eq model.email
    expect(form.name_with_email).to eq "#{model.name} <#{model.email}>"
  end

  it 'must be not persisted' do
    expect(form.persisted?).to eq false
  end

  it 'must be persisted if id present' do
    expect(comment.persisted?).to eq true
  end

  it 'must return active_model to_key' do
    expect(comment.to_key).to eq [1]
    expect(form.to_key).to eq nil
  end

  it 'must return active_model to_param' do
    expect(comment.to_param).to eq 1.to_s
    expect(form.to_param).to eq nil
  end

  it 'must build with blank bio' do
    form = SimpleForm.new(params.merge(bio: ''))
    expect(form.bio).to eq nil
  end

  it 'must strip bio attribute' do
    form = SimpleForm.new(params.merge(bio: ' test '))
    expect(form.bio).to eq 'test'
  end

  context 'multiple' do
    let(:params) do
      {
        title: 'Test order',
        non_exists_attribute: 'with some value',
        comments: [
          {
            id: 1,
            content: 'Content #1'
          },
          {
            id: 2,
            content: 'Content #2'
          }
        ]
      }
    end

    it 'must parse order params with array of comments' do
      form = OrderForm.from_params(order: params)

      expect(form.comments.is_a?(Array)).to eq true
      expect(form.comments.size).to eq 2

      expect(form.attributes.key?(:non_exists_attribute)).to eq false
      expect(form.attributes[:non_exists_attribute]).to eq nil

      comment = form.comments[0]
      expect(comment.is_a?(CommentForm)).to eq true
    end

    context 'action_controller parameters' do
      require 'action_controller/metal/strong_parameters'

      let(:order_params) do
        ActionController::Parameters.new(order: params)
      end

      it 'must parse order params' do
        form = OrderForm.from_params(order_params)

        expect(form.attributes.key?(:non_exists_attribute)).to eq false

        expect(form.comments.is_a?(Array)).to eq true
        expect(form.comments.size).to eq 2

        comment = form.comments[0]
        expect(comment.is_a?(CommentForm)).to eq true
      end
    end
  end
end
