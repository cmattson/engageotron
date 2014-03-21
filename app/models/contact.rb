# Contact records represent both members and nonmembers.
#
# These records are generally created programatically as the result of 
# importing a membership roster or an event attendance report.
#
class Contact < ActiveRecord::Base
  MEMBER_TYPE = {
  }
  validates :email, uniqueness: true
end
