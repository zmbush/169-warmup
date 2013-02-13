require 'spec_helper'

describe Users do
  before(:each) do
    Users.TESTAPI_resetFixture()

    z = Users.new
    z.user = 'zach'
    z.password = 'bush'
    z.count = 100
    z.save!

    h = Users.new
    h.user = 'hayg'
    h.password = 'astourian'
    h.count = 50
    h.save!
  end

  it "should not be able to log in with unknown user" do
    Users.login('za', 'bu').should == Users::ERR_BAD_CREDENTIALS
  end

  it "should be able to log in as zach" do
    Users.login('zach', 'bush').should == 101
  end

  it "should fail to log in with incorrect password" do
    Users.login('zach', 'bsuh').should == Users::ERR_BAD_CREDENTIALS
  end

  it "should be able to log in as hayg" do
    Users.login('hayg', 'astourian').should == 51
  end

  it 'should be able to add a new user' do
    Users.add('za', 'bu').should == 1
  end

  it 'should be able to log in as newly added user' do
    Users.add('za', 'bu')
    Users.login('za', 'bu').should == 2
  end

  it 'should not be able to create an account with an empty username' do
    Users.add('', 'bu').should == Users::ERR_BAD_USERNAME
  end

  it 'should be able to add with username of 128 characters' do
    uname = ''
    128.times do
      uname += 'a'
    end
    Users.add(uname, 'pass').should == 1
  end

  it 'should not be able to add with username of 129 characters' do
    uname = ''
    129.times do
      uname += 'a'
    end
    Users.add(uname, 'pass').should == Users::ERR_BAD_USERNAME
  end

  it 'should be able to add with password of 128 characters' do
    pass = ''
    128.times do
      pass += 'b'
    end
    Users.add('good', pass).should == 1
  end

  it 'should not be able to add with password of 129 characters' do
    pass = ''
    129.times do
      pass += 'a'
    end
    Users.add('bad', pass).should == Users::ERR_BAD_PASSWORD
  end

  it 'should not be able to re-create user zach' do
    Users.add('zach', 'bush').should == Users::ERR_USER_EXISTS
  end

  it 'should clear the database after TESTAPI_resetFixture()' do
    Users.TESTAPI_resetFixture().should == Users::SUCCESS
    Users.login('zach', 'bush').should == Users::ERR_BAD_CREDENTIALS
  end
end
