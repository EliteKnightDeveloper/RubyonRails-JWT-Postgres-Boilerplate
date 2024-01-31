Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login', to: "authentication#login"
      post 'register', to: "authentication#register"
      get 'products', to: "products#index"
      post 'products', to: "products#create"
    end
  end  
end

