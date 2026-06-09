require "test_helper"

class Public::IndustriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_industries_show_url
    assert_response :success
  end
end
