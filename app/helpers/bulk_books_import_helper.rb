module BulkBooksImportHelper
  def field_is_required?(field)
    Book.new._validators[field.to_sym].any?
  end

  def link_to_upload_file
    link_to 'Upload CSV file', '#', class: 'btn btn-primary btn-lg', id: 'select_bulk_import_file_button'
  end

  def table_column_with_errors_for_field(bulk_import_item, attr)
    content_tag :td do
      bulk_import_item.import_errors[attr].inject(bulk_import_item.attrs[attr.to_s] || "") do  |acc, item|
        acc << content_tag(:span, "!", class: 'badge badge-danger',  data: { toggle: :tooltip, placement: :top, title: item })
      end.html_safe
    end
  end

  def full_error_messages_for_import_item(bulk_import_item)
    content_tag :ul, class: 'list-unstyled' do
      bulk_import_item.import_errors.map do |field, errors|
        content_tag(:li, "#{field}: #{errors}")
      end.join.html_safe
    end
  end

  def import_error_messages
    unless @bulk_books_import.valid?
      render_flash("error" => @bulk_books_import.errors[:base])
    end
  end
end
