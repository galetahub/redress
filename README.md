# Redress

[![Gem Version](https://badge.fury.io/rb/redress.svg)](http://badge.fury.io/rb/redress)
[![Code Climate](https://codeclimate.com/github/galetahub/redress/badges/gpa.svg)](https://codeclimate.com/github/galetahub/redress)
[![Build Status](https://galetahub.semaphoreci.com/badges/redress/branches/master.svg?style=shields&key=1c60c225-c1b2-4889-9887-18aacf2e6184)](https://galetahub.semaphoreci.com/projects/redress)
[![Coverage Status](https://coveralls.io/repos/github/galetahub/redress/badge.svg?branch=master)](https://coveralls.io/github/galetahub/redress?branch=master)

## Motivation (Command pattern)

The command pattern is sometimes called a service object, an operation, an action, and probably more names that I’m not aware of. Whatever the name we gave it, the purpose of such a pattern is rather simple: take a business action and put it behind an object with a simple interface.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Requirements](#requirements)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Tests](#tests)
  - [Versioning](#versioning)
  - [Code of Conduct](#code-of-conduct)
  - [Contributions](#contributions)
  - [License](#license)
  - [History](#history)
  - [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Requirements

0. [Ruby 2.3](https://www.ruby-lang.org)
1. dry-monads
2. dry-struct
3. hashie

### Optional

To support validations just add activemodel to your project

4. activemodel

## Setup

For an insecure install, type the following:

    gem install redress

Add the following to your Gemfile:

    gem "redress"

## Usage

### Forms

```ruby
# app/forms/application_form.rb
require 'redress/form'

class ApplicationForm < Redress::Form
end
```

Let's define simple form (Built-in Types https://dry-rb.org/gems/dry-types/built-in-types/):

```ruby
class SimpleForm < ApplicationForm
  mimic :user

  define_schema do
    attribute :nickname, Redress::Types::Strict::String.default('superman')
    attribute :name, Redress::Types::StrippedString
    attribute :email, Redress::Types::StrippedString
    attribute :name_with_email, String
    attribute :age, Redress::Types::Coercible::Integer
    attribute :terms_of_service, Redress::Types::Bool
  end

  validates :name, presence: true
  validates :email, presence: true

  def map_model(user)
    self.name_with_email = "#{user.name} <#{user.email}>"
  end
end
```

Form with default values (http://dry-rb.org/gems/dry-types/default-values/):

```ruby
require 'securerandom'

class CommentForm < Redress::Form
  define_schema do
    attribute(:id, Redress::Types::Coercible::String.default { SecureRandom.uuid })
    attribute(:content, Redress::Types::String)
  end

  validates :content, presence: true
end
```

Form with multiple comments:

```ruby
class CommentForm < Redress::Form
  define_schema do
    attribute :id, Redress::Types::Coercible::Integer
    attribute :content, Redress::Types::String
  end

  validates :content, presence: true
end

class OrderForm < Redress::Form
  mimic :order

  define_schema do
    attribute :title, Redress::Types::String
    attribute :comments, Redress::Types::Array.of(CommentForm)
  end
end
```

Form with context:

```ruby
class CommentForm < Redress::Form
  define_schema do
    attribute :id, Redress::Types::Coercible::Integer
    attribute :content, Redress::Types::String
  end

  validates :content, presence: true
  validate :unsure_order_state_waiting

  private

  def unsure_order_state_waiting
    context.order.state?(:waiting)
  end
end

CommentForm.new(content: 'Hi').with_context(order: order)
```

### Commands

```ruby
# app/commands/application_command.rb
require 'redress/command'

class ApplicationCommand < Redress::Command
end
```

Simple command for user registration:

```ruby
# app/commands/users/create_command.rb
module Users
  class CreateCommand < ApplicationCommand
    def initialize(form)
      @form = form
    end

    def call
      return Failure(@form) if @form.invalid?

      user = User.new(@form.attributes)

      if user.save
        Success(user)
      else
        Failure(user)
      end
    end
  end
end
```

### Controllers

```ruby
# app/controllers/users_controller.rb
class UsersController < Account::BaseController
  respond_to :json, only: :update

  def new
    @user_form = SimpleForm.new
  end

  def create
    @user_form = SimpleForm.from_params(params)

    Users::CreateCommand.call(@user_form) do |c|
      c.success { head status: 201 }
      c.failure { |form| render status: 422, json: { errors: form.errors } }
    end
  end
end

```

## Tests

To test, run:

    bundle exec rspec ./spec/

## Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright (c) 2017 [Fodojo LLC](https://www.fodojo.com/).
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

## Credits

Developed by [Igor Galeta](https://www.linkedin.com/in/igor-galeta-585a9730/) at
[Fodojo LLC](https://www.fodojo.com/).
