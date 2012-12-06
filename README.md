# Serialize attributes like a boss

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

Initialize in a model:
```ruby
class MailingList < ActiveRecord::Base
  attr_accessible :recipients
  include SerializeListAttribute
  serialize_list_attributes :recipients, :recipients_emails_funnel_report, validation_method: :validate_for_email

  # validation method which is to be invoked on each recipients array item
  # consider email? method returns false if string is not a valid email address
  def validate_for_email value, column
    unless value.email?
      errors.add column, 'Your validation error message'
    end
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