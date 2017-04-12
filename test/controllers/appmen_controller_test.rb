require 'test_helper'

class AppmenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appman = appmen(:one)
  end

  test "should get index" do
    get appmen_url
    assert_response :success
  end

  test "should get new" do
    get new_appman_url
    assert_response :success
  end

  test "should create appman" do
    assert_difference('Appman.count') do
      post appmen_url, params: { appman: { details: @appman.details, name: @appman.name, stackid: @appman.stackid, stackmetadata: @appman.stackmetadata } }
    end

    assert_redirected_to appman_url(Appman.last)
  end

  test "should show appman" do
    get appman_url(@appman)
    assert_response :success
  end

  test "should get edit" do
    get edit_appman_url(@appman)
    assert_response :success
  end

  test "should update appman" do
    patch appman_url(@appman), params: { appman: { details: @appman.details, name: @appman.name, stackid: @appman.stackid, stackmetadata: @appman.stackmetadata } }
    assert_redirected_to appman_url(@appman)
  end

  test "should destroy appman" do
    assert_difference('Appman.count', -1) do
      delete appman_url(@appman)
    end

    assert_redirected_to appmen_url
  end
end
