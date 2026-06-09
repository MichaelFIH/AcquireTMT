require "test_helper"

class Public::PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get public_pages_home_url
    assert_response :success
  end

  test "should get sell" do
    get public_pages_sell_url
    assert_response :success
  end

  test "should get buyers" do
    get public_pages_buyers_url
    assert_response :success
  end

  test "should get insights" do
    get public_pages_insights_url
    assert_response :success
  end

  test "should get about" do
    get public_pages_about_url
    assert_response :success
  end

  test "should get contact" do
    get public_pages_contact_url
    assert_response :success
  end
end
