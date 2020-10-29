class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = collection.page(params[:page]).per(params[:per])
  end

  protected

  def collection
    Book.all
  end
end
