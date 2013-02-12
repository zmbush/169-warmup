require 'test_helper'

class TestapiControllerTest < ActionController::TestCase
  test "should get resetFixture" do
    get :resetFixture
    assert_response :success
  end
end
