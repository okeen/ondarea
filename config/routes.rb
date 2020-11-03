Rails.application.routes.draw do
  resources :books, only: :index
  resources :bulk_books_imports, except: :destroy
  devise_for :users

  root to: 'books#index'
end
