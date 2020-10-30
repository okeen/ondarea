class Book < ApplicationRecord
  validates :isbn, :title,
            presence: true
  validates :isbn,
            uniqueness: true,
            isbn_format: true
end
