require 'net/http'

class NewUploadNotificationService
  def initialize(bulk_books_upload)
    @bulk_books_upload = bulk_books_upload
  end

  def execute
    do_notification(@bulk_books_upload.uploaded_file_url)
  end

  protected

  def do_notification(s3_url)
    uri = URI(ENV['UPLOAD_NOTIFICATION_URL'])
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    https.post(uri.path, "s3_url=#{s3_url}")
  end
end