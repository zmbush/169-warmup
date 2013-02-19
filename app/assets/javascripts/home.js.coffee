# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

errCodes = {
  "1": "success"
  "-1": "Invalid username and password combination. Please try again."
  "-2": "This user name already exists. Please try again."
  "-3": "The user name should be non-empty and at most 128 characters long. Please try again."
  "-4": "The password should be at most 128 characters long. Please try again."
}

handleResponse = (data, username) ->
  if data.errCode == 1
      $('#login-box').hide()
      $('#welcome').show()
      $('#message-box').html(
        "Welcome " + username + "<br />You have logged in " + data.count + " times."
      );
  else
    $('#message-box').html(errCodes[data.errCode])

$ ->
  $('#add').click (event) ->
    event.preventDefault()
    uname = $('#uname').val()
    pass = $('#pass').val()
    
    $.post '/users/add', { 'user' : uname, 'password' : pass }, (data) ->
      handleResponse data, uname

  $('#login').click (event) ->
    event.preventDefault()
    uname = $('#uname').val()
    pass = $('#pass').val()
    
    $.post '/users/login', { 'user' : uname, 'password' : pass }, (data) ->
      handleResponse data, uname

  $('#logout').click (event) ->
    event.preventDefault()
    $('#uname').val('')
    $('#pass').val('')
    $('#message-box').html('Please enter your credentials below')
    $('#welcome').hide()
    $('#login-box').show()

