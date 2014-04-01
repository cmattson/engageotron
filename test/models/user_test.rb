require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "full name" do
    u = User.new(first_name: 'John', last_name: 'Smith')
    assert_equal 'John Smith', u.full_name
  end
end
