require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

  test "login zach" do
    post :login, :user => 'zach', :password => 'bush'
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal Users::SUCCESS, body["errCode"], "Couldn't log in as zach"
    assert_equal 101,  body["count"], "Zach's login count was wrong"
  end

  test "login hayg" do
    post :login, :user => 'hayg', :password => 'astourian'
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal Users::SUCCESS, body["errCode"], "Couldn't log in as hayg"
    assert_equal 51,  body["count"], "Hayg's login count was wrong"
  end

  test "add user" do
    post :add, :user => 'zach1', :password => 'bush'
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal Users::SUCCESS, body["errCode"], "couldn't add user"
    assert_equal 1, body["count"], "login count for new user is wrong"

    post :login, :user => 'zach1', :password => 'bush'
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal Users::SUCCESS, body["errCode"], "couldn't log in with new user"
    assert_equal 2, body["count"], "login count was wrong"
  end

  test "try to recreate zach" do
    post :add, :user => 'zach', :password => 'bush'
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal Users::ERR_USER_EXISTS, body["errCode"], "was able to create user again!"
  end

  test "try to recreate hayg" do
    post :add, :user => 'hayg', :password => 'astourian'
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal Users::ERR_USER_EXISTS, body["errCode"], "was able to create user again!"
  end
end

