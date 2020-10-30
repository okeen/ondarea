Rails.application.routes.draw do
  resources :books, only: :index
  resources :bulk_books_imports, only: [:new, :create, :show, :index] do
    member do
      patch :complete
    end
  end
  devise_for :users

  root to: 'books#index'
end
