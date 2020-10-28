class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.string :author
      t.date :publication_date
      t.string :publisher

      t.timestamps
    end
  end
end
