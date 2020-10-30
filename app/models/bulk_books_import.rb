class BulkBooksImport < ApplicationRecord
  belongs_to :user
  has_many :bulk_import_items

  mount_uploader :uploaded_file, BooksImportUploader

  validates :uploaded_file, :user_id,
            presence: true
  validate :valid_import_items

  @@IMPORTABLE_ATTRIBUTE_NAMES= %W(title author isbn publisher publication_date)
  cattr_reader :IMPORTABLE_ATTRIBUTE_NAMES

  before_create :set_uuid
  after_create :clone_uploaded_file_fields

  def extension_whitelist
    %w(csv)
  end

  def add_import_item(attrs)
    bulk_import_items.create(attrs: attrs)
  end

  protected

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def clone_uploaded_file_fields
    update(uploaded_file_name: uploaded_file.filename, uploaded_file_url: uploaded_file.url)
  end

  def valid_import_items
    errors[:base] << "There are invalid import items" if bulk_import_items.any? { |item| item.import_errors.messages.any? }
  end
end
