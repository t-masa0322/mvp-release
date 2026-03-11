require "test_helper"

class ExerciseLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get exercise_logs_new_url
    assert_response :success
  end

  test "should get create" do
    get exercise_logs_create_url
    assert_response :success
  end
end
