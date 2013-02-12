class TestapiController < ApplicationController
  def resetFixture
    response = {}
    response[:errCode] = Users.TESTAPI_resetFixture()
    render :json => response
  end

  def unitTests
    output = IO.popen('rake test')
    response =  {}
    response[:data] = output.readlines
    render :json => response
  end
end
