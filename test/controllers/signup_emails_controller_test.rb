require "test_helper"

class SignupEmailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_emails_new_url
    assert_response :success
  end

  test "should get create" do
    get signup_emails_create_url
    assert_response :success
  end

  test "should get complete" do
    get signup_emails_complete_url
    assert_response :success
  end
end
