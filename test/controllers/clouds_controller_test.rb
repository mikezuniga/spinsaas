require 'test_helper'

class CloudsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cloud = clouds(:one)
  end

  test "should get index" do
    get clouds_url
    assert_response :success
  end

  test "should get new" do
    get new_cloud_url
    assert_response :success
  end

  test "should create cloud" do
    assert_difference('Cloud.count') do
      post clouds_url, params: { cloud: { apikey: @cloud.apikey, endpoint: @cloud.endpoint, name: @cloud.name, provider: @cloud.provider, secretkey: @cloud.secretkey } }
    end

    assert_redirected_to cloud_url(Cloud.last)
  end

  test "should show cloud" do
    get cloud_url(@cloud)
    assert_response :success
  end

  test "should get edit" do
    get edit_cloud_url(@cloud)
    assert_response :success
  end

  test "should update cloud" do
    patch cloud_url(@cloud), params: { cloud: { apikey: @cloud.apikey, endpoint: @cloud.endpoint, name: @cloud.name, provider: @cloud.provider, secretkey: @cloud.secretkey } }
    assert_redirected_to cloud_url(@cloud)
  end

  test "should destroy cloud" do
    assert_difference('Cloud.count', -1) do
      delete cloud_url(@cloud)
    end

    assert_redirected_to clouds_url
  end
end
