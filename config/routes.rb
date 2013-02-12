Warmup::Application.routes.draw do
  get "testapi/resetFixture"
  get "TESTAPI/resetFixture" => "testapi#resetFixture"
  get "testapi/unitTests"
  get "TESTAPI/unitTests" => "testapi#unitTests"
  get "users/login"
  get "users/add"
  post "users/add"
  post "users/login"
  root :to => 'users#index'
end
