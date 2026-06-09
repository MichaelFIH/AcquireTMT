require "test_helper"

class Public::SellControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_sell_index_url
    assert_response :success
  end
end
