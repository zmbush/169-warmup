class UsersController < ApplicationController
  def login
    uname = params[:user]
    password = params[:password]
    response = {}
    response[:errCode] = Users.login(uname, password)
    if response[:errCode] >= 0:
      response[:count] = response[:errCode]
      response[:errCode] = Users::SUCCESS
    end
    render :json => response
  end

  def add
    uname = params[:user]
    password = params[:password]
    response = {}
    response[:errCode] = Users.add(uname, password)
    if response[:errCode] >= 0:
      response[:count] = response[:errCode]
      response[:errCode] = User::SUCCESS
    end
    render :json => response
  end
end
