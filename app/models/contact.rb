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

  default_scope { order('last_name ASC, first_name ASC') }
  scope :newest, -> { unscoped.where(member: true).order('member_since DESC').limit(5) }
  
  # Returns the contact's full name (first and last names).
  def full_name
    [first_name, last_name].join(' ')
  end

  # Returns the contact's name in directory format (last name first).
  def directory_name
    [last_name, first_name].join(', ')
  end
end
