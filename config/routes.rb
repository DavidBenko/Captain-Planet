# -*- encoding : utf-8 -*-
Rails4Template::Application.routes.draw do

  scope module: :web do
    root to: 'welcome#index'
    get '/sign-in', to: 'sessions#new', as: 'sign_in'
    delete '/sign-out', to: 'sessions#destroy', as: 'sign_out'

    #noinspection RailsParamDefResolve
    resources :sessions, only: [:create, :destroy]
  end

end
