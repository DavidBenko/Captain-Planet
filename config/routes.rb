# -*- encoding : utf-8 -*-
Rails4Template::Application.routes.draw do

  devise_for :users
  scope module: :web do
    root to: 'welcome#index'
  end

  devise_scope :user do
    get '/sign-in', to: 'devise/sessions#new', :as => :sign_in
    #post '/sign-in' => 'devise/sessions#create', :as => :user_session
    delete '/sign-out', to: 'devise/sessions#destroy', :as => :sign_out
  end


end
