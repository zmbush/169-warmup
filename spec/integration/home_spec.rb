require 'spec_helper'
require 'help/home_helper'

describe 'home page' do
  include Capybara::DSL
  include HomeHelper

  before(:each) do
    visit '/'
  end

  it 'prompts the user for credentials' do
    find('#message-box').should have_content("Please enter your credentials below")
  end

  it 'allows the user to create an account', :js => true do
    register "zabu1", "bubu"

    find('#message-box').should have_content "Welcome zabu1"
    find('#message-box').should have_content "You have logged in 1 times."

    log_out

    find('#message-box').should have_content "Please enter your credentials below"

    log_in "zabu1", "bubu"

    find('#message-box').should have_content "Welcome zabu1"
    find('#message-box').should have_content "You have logged in 2 times."
  end

  it 'does not allow the viewer to re-create a user account', :js => true do
    register "zabu2", "bubu"
    log_out
    register "zabu2", "bubu"
    find('#message-box').should have_content "This user name already exists. Please try again."
  end

  it 'does not allow the viewer to use an empty username', :js => true do
    register "", "pass"
    find('#message-box').should have_content "The username should be non-empty and at most 128 characters long. Please try again."
  end

  it 'does not allow the viewer to use a 129+ character username', :js => true do
    register 'z'*129, ''
    find('#message-box').should have_content "The username should be non-empty and at most 128 characters long. Please try again."
  end

  it 'does not allow the viewer to use a 129+ character password', :js => true do
    register 'zabu3', 'z'*129
    find('#message-box').should have_content "The password should be at most 128 characters long. Please try again."
  end

  it 'should not allow the user to log in with nonexistent user', :js => true do
    log_in "zach1", "zach"
    find('#message-box').should have_content "Invalid username and password combination. Please try again."
  end

  it 'should not allow the user to log in with the wrong password', :js => true do
    register "zach2", "zach"
    log_out
    log_in "zach2", "bush"
    find('#message-box').should have_content "Invalid username and password combination. Please try again."
  end

  it 'should be able to log in 10 times', :js => true do
    register "zach3", "bush"
    find('#message-box').should have_content "Welcome zach3"
    find('#message-box').should have_content "You have logged in 1 times."
    log_out

    10.times do |n|
      log_in "zach3", "bush"
      find('#message-box').should have_content "Welcome zach3"
      find('#message-box').should have_content "You have logged in #{n + 1} times."
      log_out
    end

    find('#message-box').should have_content "Please enter your credentials below"
  end
end
