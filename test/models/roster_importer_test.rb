require 'test_helper'
require 'tempfile'

class RosterImporterTest < ActiveSupport::TestCase
  ROSTER_CSV = 'x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x'
  EMAIL_CSV  = 'email_address'
  
  test "identify roster export" do
    assert_equal :roster, RosterImporter.new.identify(ROSTER_CSV)
  end
  
  test "identify email-only export" do
    csv = 'email_address'
    assert_equal :emails, RosterImporter.new.identify(csv)
  end
  
  test "identify unknown format with nil" do
  end
  
  test "process calls roster" do
#    rim = MiniTest::Mock.new
#    rim.expect :identify, :roster
#    t = Tempfile.new('roster')
#    t.write(ROSTER_CSV)
#    RosterImporter.new.process(t)
    t = Tempfile.new('roster')
    t.write(ROSTER_CSV)
    t.close
    r = RosterImporter.new
    r.expects(:process_roster).returns(true)
    assert_equal true, r.process(t.path)
  end
  
  test "process calls emails" do
    t = Tempfile.new('email')
    t.write('email_address')
    t.close
    r = RosterImporter.new
    r.expects(:process_email_export).returns(true)
    assert_equal true, r.process(t.path)
  end
  
end
