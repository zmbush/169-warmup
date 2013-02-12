Warmup::Application.routes.draw do
  post "testapi/resetFixture"
  post "TESTAPI/resetFixture" => "testapi#resetFixture"
  post "testapi/unitTests"
  post "TESTAPI/unitTests" => "testapi#unitTests"
  post "users/add"
  post "users/login"

  root :to => 'users#index'
end
