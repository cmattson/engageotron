# Contact records represent both members and nonmembers.
#
# These records are generally created programatically as the result of
# importing a membership roster or an event attendance report.
#
class Contact < ActiveRecord::Base
  MEMBER_TYPE = {
  }
  validates :email, uniqueness: true
  validates :member_num, uniqueness: true, allow_nil: true
  
  # Returns the contact's full name (first and last names).
  def full_name
    [first_name, last_name].join(' ')
  end
  
  # ...
  def directory_name
    [last_name, first_name].join(', ')
  end
end
