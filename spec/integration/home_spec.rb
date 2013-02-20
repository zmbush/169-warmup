require 'spec_helper'
require 'help/home_helper'

describe "Home Page" do
  include Capybara::DSL
  include HomeHelper

  # Capybara.app_host = "http://warmup-proj.herokuapp.com/"
  # Capybara.run_server = false

  context "Login Form", :js => true do
    before(:each) do
      visit '/'
    end

    after(:each) do
      save_and_open_page if example.exception != nil
    end

    it 'prompts the user for credentials' do
      page.should have_content "Please enter your credentials below"
    end

    it 'allows the user to create an account' do
      register "zabu1", "bubu"

      page.should have_content "Welcome zabu1"
      page.should have_content "You have logged in 1 times."

      log_out

      page.should have_content "Please enter your credentials below"

      log_in "zabu1", "bubu"

      page.should have_content "Welcome zabu1"
      page.should have_content "You have logged in 2 times."
    end

    it 'does not allow the viewer to re-create a user account' do
      register "zabu2", "bubu"
      log_out
      register "zabu2", "bubu"
      page.should have_content "This user name already exists. Please try again."
    end

    it 'does not allow the viewer to use an empty username' do
      register "", "pass"
      page.should have_content "The user name should be non-empty and at most 128 characters long. Please try again."
    end

    it 'does not allow the viewer to use a 129+ character username' do
      register 'z'*129, ''
      page.should have_content "The user name should be non-empty and at most 128 characters long. Please try again."
    end

    it 'does not allow the viewer to use a 129+ character password' do
      register 'zabu3', 'z'*129
      page.should have_content "The password should be at most 128 characters long. Please try again."
    end

    it 'should not allow the user to log in with nonexistent user' do
      log_in "zach1", "zach"
      page.should have_content "Invalid username and password combination. Please try again."
    end

    it 'should not allow the user to log in with the wrong password' do
      register "zach2", "zach"
      log_out
      log_in "zach2", "bush"
      page.should have_content "Invalid username and password combination. Please try again."
    end

    it 'should be able to log in 10 times' do
      register "zach3", "bush"
      page.should have_content "Welcome zach3"
      page.should have_content "You have logged in 1 times."
      log_out

      10.times do |n|
        log_in "zach3", "bush"
        page.should have_content "Welcome zach3"
        page.should have_content "You have logged in #{n + 2} times."
        log_out
      end

      page.should have_content "Please enter your credentials below"
    end

    it "should be able to successfully run this simulation" do
      tests = [
        [ 1,  "za",     "bu"    ],
        [ 1,  "zach4",  "bush"  ],
        [ 2,  "za",     "bu"    ],
        [ 2,  "zach4",  "bush"  ],
        [ 1,  "zaza",   "bubu"  ],
        [ 3,  "zach4",  "bush"  ],
        [ 1,  "molly",  "raven" ],
        [ 4,  "zach4",  "bush"  ],
        [ 5,  "zach4",  "bush"  ],
        [ 2,  "zaza",   "bubu"  ],
        [ 6,  "zach4",  "bush"  ],
        [ 3,  "zaza",   "bubu"  ],
        [ 3,  "za",     "bu"    ],
        [ 4,  "zaza",   "bubu"  ],
        [ 2,  "molly",  "raven" ],
        [ 7,  "zach4",  "bush"  ],
        [ 5,  "zaza",   "bubu"  ],
        [ 4,  "za",     "bu"    ],
        [ 8,  "zach4",  "bush"  ],
        [ 6,  "zaza",   "bubu"  ],
        [ 7,  "zaza",   "bubu"  ],
        [ 8,  "zaza",   "bubu"  ],
        [ 3,  "molly",  "raven" ],
        [ 5,  "za",     "bu"    ],
      ]

      tests.each do |count, uname, pass|
        if count == 1
          register uname, pass
        else
          log_in uname, pass
        end

        page.should have_content "Welcome #{uname}"
        page.should have_content "You have logged in #{count} times."

        log_out
      end
    end
  end
end
