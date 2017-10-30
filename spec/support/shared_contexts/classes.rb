# frozen_string_literal: true

class User
  attr_reader :name, :email, :age

  def initialize(options)
    @name = options[:name]
    @email = options[:email]
    @age = options[:age]
  end
end

class SimpleCommand < Redress::Command
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

class SimpleForm < Redress::Form
  mimic :user

  define_schema do
    attribute :nickname, Redress::Types::Strict::String.default("superman")
    attribute :name, Redress::Types::String
    attribute :email, Redress::Types::String
    attribute :name_with_email, Redress::Types::String
    attribute :age, Redress::Types::Form::Int
  end

  validates :name, presence: true
  validates :email, presence: true

  def map_model(user)
    self.name_with_email = "#{user.name} <#{user.email}>"
  end
end

class CommentForm < Redress::Form
  define_schema do
    attribute :id, Redress::Types::Form::Int
    attribute :content, Redress::Types::String
  end

  validates :content, presence: true
end

class OrderForm < Redress::Form
  mimic :order

  define_schema do
    attribute :title, Redress::Types::String
    attribute :comments, Redress::Types::Array.member(CommentForm)
  end
end
