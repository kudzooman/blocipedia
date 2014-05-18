Blocipedia::Application.routes.draw do

  resources :charges, only: [:new, :create]

  devise_for :users
  
  resources :wikis  

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end

