# frozen_string_literal: true

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

  schema do
    attribute :name, String
    attribute :email, String
    attribute :name_with_email, String
  end

  validates :name, presence: true
  validates :email, presence: true

  def map_model(user)
    self.name_with_email = "#{user.name} <#{user.email}>"
  end
end

class User
  attr_reader :name, :email

  def initialize(options)
    @name = options[:name]
    @email = options[:email]
  end
end
