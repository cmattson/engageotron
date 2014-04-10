require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @contact = contacts(:one)
  end

  test 'should get index' do
    sign_in users(:one)
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end
  test 'should not get index' do
    sign_out :user
    get :index
    assert_response 302
    assert_redirected_to new_user_session_path
    assert_nil assigns(:contacts)
  end

  test 'should get new' do
    sign_in users(:one)
    get :new
    assert_response :success
  end
  test 'should not get new' do
    sign_out :user
    get :new
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test 'should create contact' do
    sign_in users(:one)
    assert_difference('Contact.count') do
      post :create, contact: { address1: @contact.address1, address2: @contact.address2, city: @contact.city, company_name: @contact.company_name, first_name: @contact.first_name, last_name: @contact.last_name, member: @contact.member, member_since: @contact.member_since, member_type: @contact.member_type, phone: @contact.phone, state: @contact.state, zip_code: @contact.zip_code }
    end

    assert_redirected_to contact_path(assigns(:contact))
  end
  test 'should not create contact' do
    sign_out :user
    assert_no_difference('Contact.count') do
      post :create, contact: { address1: @contact.address1, address2: @contact.address2, city: @contact.city, company_name: @contact.company_name, first_name: @contact.first_name, last_name: @contact.last_name, member: @contact.member, member_since: @contact.member_since, member_type: @contact.member_type, phone: @contact.phone, state: @contact.state, zip_code: @contact.zip_code }
    end
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test 'should show contact' do
    sign_in users(:one)
    get :show, id: @contact
    assert_response :success
  end
  test 'should not show contact' do
    sign_out :user
    get :show, id: @contact
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test 'should get edit' do
    sign_in users(:one)
    get :edit, id: @contact
    assert_response :success
  end
  test 'should not get edit' do
    sign_out :user
    get :edit, id: @contact
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test 'should update contact' do
    sign_in users(:one)
    patch :update, id: @contact, contact: { address1: @contact.address1, address2: @contact.address2, city: @contact.city, company_name: @contact.company_name, first_name: @contact.first_name, last_name: @contact.last_name, member: @contact.member, member_since: @contact.member_since, member_type: @contact.member_type, phone: @contact.phone, state: @contact.state, zip_code: @contact.zip_code }
    assert_redirected_to contact_path(assigns(:contact))
  end
  test 'should not update contact' do
    sign_out :user
    patch :update, id: @contact, contact: { address1: @contact.address1, address2: @contact.address2, city: @contact.city, company_name: @contact.company_name, first_name: @contact.first_name, last_name: @contact.last_name, member: @contact.member, member_since: @contact.member_since, member_type: @contact.member_type, phone: @contact.phone, state: @contact.state, zip_code: @contact.zip_code }
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test 'should destroy contact' do
    sign_in users(:one)
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_redirected_to contacts_path
  end
  test 'should not destroy contact' do
    sign_out :user
    assert_no_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_redirected_to new_user_session_path
  end
end
