require "test_helper"

class Public::LeadsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_leads_create_url
    assert_response :success
  end
end
