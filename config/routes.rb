Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only:[:create, :destroy]
    get "search_form" => "users#search_form"

  get 'follows' => 'relationships#followed'
  get 'followers' => 'relationships#follower'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
