Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get "/home/about" => "homes#about"

# resorces :userだとuninitialized constant UserControllerというエラーが出た
  resources :books, only: [:create, :show, :index, :edit, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
  resources :users

end
