class AddFilenameAndUrlToBooksImports < ActiveRecord::Migration[6.0]
  def change
    change_table :bulk_books_imports do |t|
      t.string :uploaded_file_url
      t.string :uploaded_file_name
      t.string :uuid
    end
  end
end
