require 'csv'

class BooksCsvImportCreationService
  attr_reader :instance

  def initialize(attrs = {})
    @user = attrs[:user]
    @csv_file = attrs[:uploaded_file]
    @instance = BulkBooksImport.new(user: @user, uploaded_file: @csv_file)
  end

  def save
    if @instance.save
      @instance.started!
      imported_items.each do |item|
        instance.add_import_item(
          title: item[0],
          author: item[1],
          isbn: item[2],
          publisher: item[3],
          publication_date: item[4]
        )
      end
      NewUploadNotificationJob.perform_later(@instance)
    end
  end

  def imported_items
    CSV.parse(File.read(@csv_file), headers: true)
  end
end