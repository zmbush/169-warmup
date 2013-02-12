require 'test_helper'

class UsersTest < ActiveSupport::TestCase
  test "empty db, login fails" do
    assert Users.login('za', 'bu') == Users::ERR_BAD_CREDENTIALS
  end

  test "login as zach" do
    assert Users.login('zach', 'bush') == 101
  end

  test "fail to login as zach" do
    assert Users.login('zach', 'bsuh') == Users::ERR_BAD_CREDENTIALS
  end

  test "login as hayg" do
    assert Users.login('hayg', 'astourian') == 51
  end

  test "add new user" do
    assert Users.add('za', 'bu') == 1
    assert Users.login('za', 'bu') == 2
  end

  test "add username empty" do
    assert Users.add('', 'bu') == Users::ERR_BAD_USERNAME
  end

  test "add username too long" do
    uname = ''
    128.times do
      uname += 'a'
    end
    assert Users.add(uname, 'pass') == 1
    uname += 'a'
    assert Users.add(uname, 'pass') == Users::ERR_BAD_USERNAME
  end

  test "add password too long" do
    pass = ''
    128.times do
      pass += 'b'
    end
    assert Users.add('good', pass) == 1
    pass += 'b'
    assert Users.add('bad', pass) == Users::ERR_BAD_PASSWORD
  end

  test "try to recreate zach" do
    assert Users.add('zach', 'bush') == Users::ERR_USER_EXISTS
  end

  test "ensure TESTAPI_resetFixture works" do
    assert Users.login('zach', 'bush') != Users::ERR_BAD_CREDENTIALS
    assert Users.TESTAPI_resetFixture() == Users::SUCCESS
    assert Users.login('zach', 'bush') == Users::ERR_BAD_CREDENTIALS
  end
end
