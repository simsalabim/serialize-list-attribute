# Serialize attributes like a boss ![Build Status](https://travis-ci.org/simsalabim/serialize-list-attribute.png "Build Status")

This gem adds helper methods to serialize AR model simple text attribute to an array or hash,
handles the field updates and allows to perform per-item validation.

## Installation

Add this line to your application's Gemfile:

    gem 'serialize-list-attribute'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serialize-list-attribute

## Usage
Example: we store emails recipients as simple text field, but want to operate them as it was an array and,
into the bargain, perform internal validation on create/update.

In a model:
```ruby
class MailingList < ActiveRecord::Base
  attr_accessible :recipients

  include SerializeListAttribute
  # this will create an attr_writer with prefix 'raw_' sou you could use it in views to assign string
  # values, not arrays/hashes, whereas the field itself (e.g. :recipients) will accept an array/hash.
  serialize_list_attributes :recipients, validation_method: :validate_length

  # validation method which is to be invoked on each recipients array item
  def validate_length item, column
    errors.add column, 'Should be 5 characters or longer!' if item.length < 5
  end
end
```

In a view:
```ruby
= semantic_form_for resource do |f|
  = f.input :raw_recipients, as: :text
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request