require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test "#full_name" do
    u = Contact.new(first_name: 'John', last_name: 'Smith')
    assert_equal 'John Smith', u.full_name
  end
  
  test "#directory_name" do
    u = Contact.new(first_name: 'John', last_name: 'Smith')
    assert_equal 'Smith, John', u.directory_name
  end
end
