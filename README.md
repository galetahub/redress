# Redress

[![Gem Version](https://badge.fury.io/rb/redress.svg)](http://badge.fury.io/rb/redress)
[![Code Climate](https://codeclimate.com/github/galetahub/redress/badges/gpa.svg)](https://codeclimate.com/github/galetahub/redress)
[![Build Status](https://semaphoreci.com/api/v1/igor-galeta/redress/branches/master/shields_badge.svg)](https://semaphoreci.com/igor-galeta/redress)
[![Coverage Status](https://coveralls.io/repos/github/galetahub/redress/badge.svg?branch=master)](https://coveralls.io/github/galetahub/redress?branch=master)
[![Dependency Status](https://gemnasium.com/badges/github.com/galetahub/redress.svg)](https://gemnasium.com/github.com/galetahub/redress)

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
1. wisper
2. fast_attributes
3. hashie
4. activemodel

## Setup

For an insecure install, type the following:

    gem install redress

Add the following to your Gemfile:

    gem "redress"

## Usage

### Forms

``` ruby
# app/forms/application_form.rb
require 'redress/form'

class ApplicationForm < Redress::Form
end
```

Let's define simple form:

``` ruby
class SimpleForm < ApplicationForm
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
```

### Commands

``` ruby
# app/commands/application_command.rb
require 'redress/form'

class ApplicationCommand < Redress::Commad
end
```

Or if you are using ActiveRecord:

``` ruby
# app/commands/application_command.rb
require 'redress/form'

class ApplicationCommand < Redress::Commad
  def transaction(&block)
    ActiveRecord::Base.transaction(&block) if block_given?
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
