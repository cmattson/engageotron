# Contact records represent both members and nonmembers.
#
# These records are generally created programatically as the result of
# importing a membership roster or an event attendance report.
#
class Contact < ActiveRecord::Base
  MEMBER_TYPE = {
  }
  validates :email, uniqueness: true, allow_nil: true
  validates :member_num, uniqueness: true, allow_nil: true

  default_scope { order('last_name ASC, first_name ASC') }
  scope :newest, -> { unscoped.where(member: true).order('member_since DESC').limit(5) }
  
  # Scopes for join date reporting
  scope :join_dates, -> { unscoped.where(member: true).order(:member_since).pluck(:member_since) }
  scope :last_joined, -> { unscoped.where(member: true).order('member_since DESC').limit(1) }
  scope :first_joined, -> { unscoped.where(member:true).order('member_since ASC').limit(1) }
  
  # Returns the contact's full name (first and last names).
  def full_name
    [first_name, last_name].join(' ')
  end

  # Returns the contact's name in directory format (last name first).
  def directory_name
    [last_name, first_name].join(', ')
  end
  
  # Returns median join date of members
  def self.median_age
    times = join_dates.map{ |x| x.to_time.to_i }
    # If even array, mean the two middle values.
    if times.size.even?
      Time.at((times[times.size / 2] + times[times.size / 2 - 1]) / 2).to_date
    # If odd array, use the true median.
    else
      Time.at(times[times.size / 2]).to_date
    end
  end
end
