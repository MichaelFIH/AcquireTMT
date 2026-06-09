require "test_helper"

class Admin::LeadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_leads_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_leads_show_url
    assert_response :success
  end
end
