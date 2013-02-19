require 'spec_helper'

module HomeHelper
  def log_in (uname, password)
    fill_in "uname", :with => uname
    fill_in "pass", :with => password

    click_on "Login"
  end

  def register (uname, password)
    fill_in "uname", :with => uname
    fill_in "pass", :with => password

    click_on "Add User"
  end

  def log_out
    click_on "Logout"
  end
end
