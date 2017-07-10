Rails.application.routes.draw do
  get 'users/new'

  #控制器中的动作路由
  get '/help',    to:'static_pages#help'#具名路由
  get '/about',   to:'static_pages#about'
  get '/contact', to:'static_pages#contact'
  get '/signup',  to:'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'#根路由的指向
end
