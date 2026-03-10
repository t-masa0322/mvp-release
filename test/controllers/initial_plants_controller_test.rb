require "test_helper"

class InitialPlantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get initial_plants_index_url
    assert_response :success
  end

  test "should get create" do
    get initial_plants_create_url
    assert_response :success
  end
end
