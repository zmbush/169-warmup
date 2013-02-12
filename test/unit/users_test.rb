require 'test_helper'

class UsersTest < ActiveSupport::TestCase
  test "empty db, login fails" do
    assert Users.login('za', 'bu') == -1
  end

  test "login as zach" do
    assert Users.login('zach', 'bush') == 101
  end

  test "login as hayg" do
    assert Users.login('hayg', 'astourian') == 51
  end

  test "add new user" do
    assert Users.add('za', 'bu') == 1
    assert Users.login('za', 'bu') == 2
  end
end
