class CreateBulkImportItems < ActiveRecord::Migration[6.0]
  def change
    create_table :bulk_import_items do |t|
      t.references :bulk_books_import, null: false, foreign_key: true
      t.hstore :attrs
      t.references :book, null: true, foreign_key: true

      t.timestamps
    end
  end
end
