Rails.application.routes.draw do
  get 'start', to: 'sign_up#show', as: :show
  post 'next', to: 'sign_up#create', as: :create
  patch 'done', to: 'sign_up#update', as: :update

  get 'error', to: 'sign_up#error', as: :error
end
