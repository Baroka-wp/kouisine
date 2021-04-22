require "test_helper"

class RecettesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recettes_index_url
    assert_response :success
  end
end
