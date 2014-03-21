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
    elsif (1..7).cover?(field_count) && line.split(',').include?('email_address')
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
  end

  # Import members from an Email Export.
  def process_email_export
    @roster.rewind
    CSV.foreach(@roster, {headers: true}) do |c|
      # c["member_first_name"]
      # c["member_last_name"]
      # c["member_company"]
      # c["chapter_name"]
      # c["category_name"]
      # c["phone_number"]
      # c["email_address"]
    end
  end
end