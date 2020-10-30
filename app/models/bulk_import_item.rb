class BulkImportItem < ApplicationRecord
  belongs_to :bulk_books_import
  belongs_to :book, required: false

  def import_errors
    imported_instance.valid?
    imported_instance.errors
  end

  def imported_instance
    @_imported_instance ||= book || Book.new(attrs)
  end
end
