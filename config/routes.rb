Rails.application.routes.draw do
  #控制器中的动作路由
  get 'static_pages/home'

  get 'static_pages/help'
  get 'static_pages/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
