Rails.application.routes.draw do
  
  get ":controller(/:action(/:id))"
  post ":controller(/:action(/:id))"
  root "home#index"
  
end
