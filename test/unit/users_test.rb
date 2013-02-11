require 'test_helper'

class UsersTest < ActiveSupport::TestCase
  test "empty db, login fails" do
    n = Users.new
    assert n.login('za', 'bu') == -1
  end

  test "login as zach" do
    n = Users.new
    assert n.login('zach', 'bush') == 101
  end
end
