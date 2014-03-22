require 'test_helper'
require 'tempfile'

class RosterImporterTest < ActiveSupport::TestCase
  ROSTER_CSV = 'x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x'
  EMAIL_CSV  = '"email_address"'
  
  test "identify roster export" do
    assert_equal :roster, RosterImporter.new.identify(ROSTER_CSV)
  end
  
  test "identify email-only export" do
    assert_equal :emails, RosterImporter.new.identify(EMAIL_CSV)
  end
  
  test "identify unknown format with nil" do
  end
  
  test "process calls roster" do
    t = Tempfile.new('roster')
    t.write(ROSTER_CSV)
    t.close
    r = RosterImporter.new
    r.expects(:process_roster).returns(true)
    assert_equal true, r.process(t.path)
  end
  
  test "process calls emails" do
    t = Tempfile.new('email')
    t.write(EMAIL_CSV)
    t.close
    r = RosterImporter.new
    r.expects(:process_email_export).returns(true)
    assert_equal true, r.process(t.path)
  end
  
  # This test uses a sample CSV file stored in /test/csvs.
  test "process_roster handles new contacts" do
    Contact.destroy_all
    fpath = File.expand_path('../../csvs/roster.csv', __FILE__)
    RosterImporter.new.process(fpath)
    assert_equal 1, Contact.count
    c = Contact.first
    assert_equal 'Colin', c.first_name
    assert_equal 'Mattson', c.last_name
    assert_equal 'colin@colinmattson.com', c.email
    assert_equal 'Pixel Warrior Corps LLC', c.company_name
  end
  
  # This test uses a sample CSV file stored in /test/csvs.
  test "process_roster handles existing contacts" do
    Contact.destroy_all
    Contact.create!(email: 'colin@colinmattson.com')
    fpath = File.expand_path('../../csvs/roster.csv', __FILE__)
    RosterImporter.new.process(fpath)
    assert_equal 1, Contact.count
    c = Contact.first
    assert_equal 'Colin', c.first_name
    assert_equal 'Mattson', c.last_name
    assert_equal 'colin@colinmattson.com', c.email
    assert_equal 'Pixel Warrior Corps LLC', c.company_name
  end
  
  # This test uses a sample CSV file stored in /test/csvs.
  test "process_email_export" do
    fpath = File.expand_path('../../csvs/email.csv', __FILE__)
    RosterImporter.new.process(fpath)
    c = Contact.find_by(email: 'ansel@adams.example.com')
    assert_equal 'Ansel', c.first_name
    assert_equal 'Adams', c.last_name
    assert_equal 'ASMP', c.company_name
  end
  
  # This test uses a sample CSV file stored in /test/csvs.
  test "process_email_export existing" do
    Contact.destroy_all
    Contact.create!(email: 'ansel@adams.example.com')
    fpath = File.expand_path('../../csvs/email.csv', __FILE__)
    RosterImporter.new.process(fpath)
    c = Contact.find_by(email: 'ansel@adams.example.com')
    assert_equal 'Ansel', c.first_name
    assert_equal 'Adams', c.last_name
    assert_equal 'ASMP', c.company_name
  end
  
end
