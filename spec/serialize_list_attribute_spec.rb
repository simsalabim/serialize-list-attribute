require 'support/spec_helper'
require 'support/active_record'
require 'serialize-list-attribute'

class MailingList < ActiveRecord::Base
  attr_accessible :recipients

  def validate_length item, column
    errors.add column, 'Should be 5 characters or longer!' if item.length < 5
  end
end

describe MailingList do

  it 'should have plain text recipients attribute default' do
    subject.recipients = 'cyberdyne_systems@model.101, the@terminator.com'
    subject.recipients.is_a?(String).should be_true
  end

  it 'should have recipients attribute serialized into an array if the gem is used with defaults' do
    subject.class.send :include, SerializeListAttribute
    subject.class.send :serialize_list_attributes, :recipients
    subject.recipients = %w(cyberdyne_systems@model.101 the@terminator.com)

    subject.recipients.value.is_a?(Array).should be_true
    subject.should have(:no).errors_on(:raw_recipients)
  end

  it 'should have recipients attribute serialized into a hash if the gem is configured properly' do
    subject.class.send :include, SerializeListAttribute
    subject.class.send :serialize_list_attributes, :recipients, as: :hash
    subject.recipients = { person: 'cyberdyne_systems@model.101', nickname: 'the@terminator.com' }

    subject.recipients.value.is_a?(Hash).should be_true
    subject.should have(:no).errors_on(:raw_recipients)
  end

  it 'should validate each recipients attribute particle if the gem is configured to do so' do
    subject.class.send :include, SerializeListAttribute
    subject.class.send :serialize_list_attributes, :recipients, validation_method: :validate_length

    subject.raw_recipients = 'arnie, 12'
    subject.should have(1).error_on(:raw_recipients)
  end
end