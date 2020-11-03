class BulkBooksImport < ApplicationRecord
  belongs_to :user
  has_many :bulk_import_items, dependent: :destroy

  mount_uploader :uploaded_file, BooksImportUploader

  validates :uploaded_file, :user_id,
            presence: true
  validate :valid_import_items

  @@IMPORTABLE_ATTRIBUTE_NAMES= %W(title author isbn publisher publication_date)
  cattr_reader :IMPORTABLE_ATTRIBUTE_NAMES

  after_initialize :set_uuid
  after_create :clone_uploaded_file_fields

  enum status: [:pending, :with_errors, :started, :finished]

  def extension_whitelist
    %w(csv)
  end

  def add_import_item(attrs)
    bulk_import_items.create(attrs: attrs)
  end

  def complete!
    if valid? && started? && valid_import_items
      books = bulk_import_items.map &:complete_import!
      finished!
      return books.count == bulk_import_items.count
    end
  end

  protected

  def set_uuid
    self.uuid ||= SecureRandom.hex(8)
  end

  def clone_uploaded_file_fields
    update(uploaded_file_name: uploaded_file.filename, uploaded_file_url: uploaded_file.url)
  end

  def valid_import_items
    if bulk_import_items.any? { |item| item.import_errors.messages.any? }
      errors[:base] << "There are invalid import items"
      false
    else
      true
    end
  end
end
