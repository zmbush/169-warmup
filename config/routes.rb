Warmup::Application.routes.draw do
  get "TESTAPI/resetFixture"
  get "TESTAPI/unitTests"
  get "users/login"
  get "users/add"
  post "users/add"
  post "users/login"
  root :to => 'users#index'
end
