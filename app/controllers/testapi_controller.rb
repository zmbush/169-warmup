class TestapiController < ApplicationController
  def resetFixture
    response = {}
    response[:errCode] = Users.TESTAPI_resetFixture()
    render :json => response
  end

  def unitTests
    output = IO.popen('bundle exec rake')
    response =  {}
    lines = output.readlines
    lines.each do |line|
      if line =~ /.* examples, .* failures\n/
        parts = line.split
        response[:totalTests] = parts[0]
        response[:nrFailed] = parts[2]
      end
    end
    response[:output] = lines.join("")
    render :json => response
  end
end
