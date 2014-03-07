require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, contact: { address1: @contact.address1, address2: @contact.address2, city: @contact.city, company_name: @contact.company_name, first_name: @contact.first_name, last_name: @contact.last_name, member: @contact.member, member_since: @contact.member_since, member_type: @contact.member_type, phone: @contact.phone, state: @contact.state, zip_code: @contact.zip_code }
    end

    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should show contact" do
    get :show, id: @contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact
    assert_response :success
  end

  test "should update contact" do
    patch :update, id: @contact, contact: { address1: @contact.address1, address2: @contact.address2, city: @contact.city, company_name: @contact.company_name, first_name: @contact.first_name, last_name: @contact.last_name, member: @contact.member, member_since: @contact.member_since, member_type: @contact.member_type, phone: @contact.phone, state: @contact.state, zip_code: @contact.zip_code }
    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_redirected_to contacts_path
  end
end
