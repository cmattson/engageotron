require 'test_helper'

class ChapterEventsControllerTest < ActionController::TestCase
  setup do
    @chapter_event = chapter_events(:one)
  end

  test "should get index" do
    sign_in users(:two)
    get :index
    assert_response :success
    assert_not_nil assigns(:chapter_events)
  end

  test "should get new" do
    sign_in users(:two)
    get :new
    assert_response :success
  end

  test "should create chapter_event" do
    sign_in users(:two)
    assert_difference('ChapterEvent.count') do
      post :create, chapter_event: { date: @chapter_event.date, name: @chapter_event.name }
    end

    assert_redirected_to chapter_event_path(assigns(:chapter_event))
  end

  test "should show chapter_event" do
    sign_in users(:two)
    get :show, id: @chapter_event
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:two)
    get :edit, id: @chapter_event
    assert_response :success
  end

  test "should update chapter_event" do
    sign_in users(:two)
    patch :update, id: @chapter_event, chapter_event: { date: @chapter_event.date, name: @chapter_event.name }
    assert_redirected_to chapter_event_path(assigns(:chapter_event))
  end

  test "should destroy chapter_event" do
    sign_in users(:two)
    assert_difference('ChapterEvent.count', -1) do
      delete :destroy, id: @chapter_event
    end

    assert_redirected_to chapter_events_path
  end
end
