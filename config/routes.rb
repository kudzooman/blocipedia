Blocipedia::Application.routes.draw do

  resources :charges, only: [:new, :create]

  devise_for :users
  
  resources :wikis 
   # nested route for collaborators, only need create, destroy

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end

