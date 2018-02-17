require 'test_helper'

class VideosControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get videos_show_url
    assert_response :success
  end

  test "should get accept" do
    get videos_accept_url
    assert_response :success
  end

  test "should get reject" do
    get videos_reject_url
    assert_response :success
  end

  test "should get retry" do
    get videos_retry_url
    assert_response :success
  end

end
