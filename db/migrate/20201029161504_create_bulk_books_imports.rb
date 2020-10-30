class CreateBulkBooksImports < ActiveRecord::Migration[6.0]
  def change
    create_table :bulk_books_imports do |t|
      t.string :type
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.string :uploaded_file

      t.timestamps
    end
  end
end
