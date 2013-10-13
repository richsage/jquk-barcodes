JqukBarcodesV2::Application.routes.draw do
  root 'general#index'
  resources :jobs
end
