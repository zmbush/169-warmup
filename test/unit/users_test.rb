require 'test_helper'

class UsersTest < ActiveSupport::TestCase
  test "empty db, login fails" do
    assert Users.login('za', 'bu') == -1
  end

  test "login as zach" do
    assert Users.login('zach', 'bush') == 101
  end
end
