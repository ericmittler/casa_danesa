CasaDanesa::Application.routes.draw do
  resources :blog_posts

  match '/', to: 'home#index', via: :get
  match '/home', to: 'home#index', via: :get
end
