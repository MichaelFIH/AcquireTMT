require "test_helper"

class Public::ToolsControllerTest < ActionDispatch::IntegrationTest
  test "should get find_buyers" do
    get public_tools_find_buyers_url
    assert_response :success
  end

  test "should get valuation" do
    get public_tools_valuation_url
    assert_response :success
  end

  test "should get market_comps" do
    get public_tools_market_comps_url
    assert_response :success
  end
end
