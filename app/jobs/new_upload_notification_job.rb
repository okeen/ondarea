class NewUploadNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @bulk_books_upload = args[0]
    begin
      NewUploadNotificationService.new(@bulk_books_upload).execute
    rescue Exception => e
      Rails.logger.warn("[NewUploadNotificationJob] could not process job because of: #{e.message}")
    end
  end
end
