require "test_helper"

class MypagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mypages_show_url
    assert_response :success
  end

  test "should get edit" do
    get mypages_edit_url
    assert_response :success
  end
end
