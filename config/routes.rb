Warmup::Application.routes.draw do
  get "login" => "home#login"

  post "welcome" => "home#welcome"

  post "testapi/resetFixture"
  post "TESTAPI/resetFixture" => "testapi#resetFixture"
  post "testapi/unitTests"
  post "TESTAPI/unitTests" => "testapi#unitTests"
  post "users/add"
  post "users/login"
  root :to => 'home#login'
end
