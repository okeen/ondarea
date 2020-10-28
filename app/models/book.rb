class Book < ApplicationRecord
  validates :isbn, :title,
            presence: true
end
