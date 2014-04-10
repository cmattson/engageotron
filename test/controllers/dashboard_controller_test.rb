require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get index" do
    sign_in users(:one)
    get :index
    assert_response :success
  end
  
  test "should get signin" do
    sign_out :user
    get :index
    assert_response 302
    assert_redirected_to new_user_session_path
  end

end
