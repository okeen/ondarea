class BulkBooksImportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bulk_books_imports = collection.order(created_at: :desc).page(params[:page])
  end

  def new
    @bulk_books_import = BulkBooksImport.new
  end

  def create
    import_service = BooksCsvImportCreationService.new(permitted_books_import_params.merge(user: current_user))
    if import_service.save
      redirect_to [import_service.instance], success: t(".success")
    else
      redirect_to [:new, :bulk_books_import], error: t(".error")
    end
  end

  def show
    @bulk_books_import = collection.find(params[:id])
  end

  protected

  def collection
    current_user.bulk_books_imports.all
  end

  def permitted_books_import_params
    params[:bulk_books_import].permit(:uploaded_file)
  end
end
