module TestModelsHelper
  def csv_file_upload(filename)
    Rack::Test::UploadedFile.new(
        File.open(File.join(Rails.root, filename)),
        "text/csv"
    )
  end
end