module ContactsHelper
  def member_category
    render partial: 'member_category',
           locals: { color: @contact.member_cat_name.downcase.gsub(/ /, '-') }
  end
end
