require 'csv'

# Imports member roster CSVs from ASMP National.
#
# IMPORTANT NOTE:
# There are *two* roster formats.
# 1. "True" roster, from Utilities, exports the complete member records.
# 2. Email export, from Chapters, exports basic contact information
#    (email, first, last, company, chapter, category, phone)
#
# This class attempts to automatically detect and process either one
# transparently.
#
# Note that rejecting "foreign" formats (those not generated by the ASMP site)
# is not particularly robust; anything with 1-8 columns and a `email_address`
# label will be accepted. This is intentional but is not set in stone.
class RosterImporter
  # Given an unparsed line, determines which type of roster this is.
  #
  # Chapter Rosters are identified by the presence of 36 data fields.
  #
  # CSV Email Exports contain between 1 and 7 columns of known field type.
  # We attempt to distinguish between valid exports and unrelated CSV data
  # by checking for the presence of known fields.
  #
  # Valid CSV Email Export types are:
  # * "member_first_name"
  # * "member_last_name"
  # * "member_company"
  # * "chapter_name"
  # * "category_name"
  # * "phone_number"
  # * "email_address"
  def identify(line)
    field_count = line.split(',').count
    if field_count == 36
      :roster
    elsif (1..7).cover?(field_count) && line.chomp.split(', ').include?('"email_address"')
      :emails
    else
      false
    end
  end

  # Given a CSV file path, open the file and process it.
  # This method passes all the heavy lifting off to other methods.
  def process(file)
    @roster = File.open(file)
    case identify(@roster.gets)
    when :roster
      process_roster
    when :emails
      process_email_export
    else
    end
  end

  # Import members from a Chapter Roster.
  def process_roster
    @roster.rewind
    CSV.foreach(@roster, {headers: true}) do |row|
      c = Contact.find_or_create_by(email: row["member_primary_email_address"])
      c.member_num    ||= row["member_id"]
      c.first_name    ||= row["member_first_name"]
      c.middle_name   ||= row["member_middle_name"]
      c.last_name     ||= row["member_last_name"]
      c.suffix        ||= row["member_suffix"]
      c.company_name  ||= row["member_company"]
      c.member_cat_id ||= row["member_current_category_id"]
      c.member_cat_name ||= row["member_current_category_name"]
      # row["member_category_change_date"]
      c.member_since  ||= row["member_join_date"]
      # row["member_rejoin_date"]
      # row["member_drop_date"]
      # row["member_standing"]
      # row["member_current_chapter_id"]
      # row["member_current_chapter_name"]
      # row["member_primary_address_private"]
      c.address1      ||= row["member_primary_address_line1"]
      c.address2      ||= row["member_primary_address_line2"]
      c.city          ||= row["member_primary_address_city"]
      c.state         ||= row["member_primary_address_state"]
      c.zip_code      ||= row["member_primary_address_zip"]
      # row["member_primary_address_county"]
      # row["member_primary_address_county_id"]
      # row["member_primary_phone_private"]
      # row["member_primary_phone_type"]
      c.phone ||= row["member_primary_phone_number"]
      # row["member_primary_fax_private"]
      # row["member_primary_fax_type"]
      # row["member_primary_fax_number"]
      # row["member_primary_email_private"]
      # row["member_primary_email_type"]
      # row["member_primary_email_address"]
      # row["member_primary_website_type"]
      # row["member_primary_website_url"]
      c.specialties   ||= row["member_memberspecialties"]
      c.save!
    end
  end

  # Import members from an Email Export.
  def process_email_export
    @roster.rewind
    CSV.foreach(@roster, {headers: true, col_sep: ', '}) do |row|
      c = Contact.find_or_create_by(email: row['email_address'])
      c.first_name    ||= row["member_first_name"]
      c.last_name     ||= row["member_last_name"]
      c.company_name  ||= row["member_company"]
      c.phone         ||= row["phone_number"]
      # c["chapter_name"]
      # c["category_name"]
      c.save!
    end
  end
end
