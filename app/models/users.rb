class Users < ActiveRecord::Base
  SUCCESS = 1
  ERR_BAD_CREDENTIALS = -1
  ERR_USER_EXISTS = -2
  ERR_BAD_USERNAME = -3
  ERR_BAD_PASSWORD = -4

  def self.login(uname, password)
    user = Users.find_by_user(uname)
    if user == nil
      return ERR_BAD_CREDENTIALS
    end
    if user.password == password
      user.increment!(:count)
      return user.count
    end

    return ERR_BAD_CREDENTIALS
  end

  def self.add(uname, password)
    if uname.blank?
      return ERR_BAD_USERNAME
    end
    if uname.length > 128
      return ERR_BAD_USERNAME
    end
    if password.length > 128
      return ERR_BAD_PASSWORD
    end
    user = Users.find_by_user(uname)
    if user != nil
      return ERR_USER_EXISTS
    end
    n = Users.new
    n.user = uname
    n.password = password
    n.count = 1
    n.save!
    return n.count
  end

  def self.TESTAPI_resetFixture()
    Users.delete_all()
    return SUCCESS
  end
end
