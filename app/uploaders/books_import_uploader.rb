require 'carrierwave/orm/activerecord'

class BooksImportUploader < CarrierWave::Uploader::Base
  def content_type_whitelist
    "text/csv"
  end

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore.pluralize}/#{mounted_as}/#{model.id}"
  end

  def store_path(for_file = filename)
    "#{store_dir}/#{for_file}"
  end

  # Fixed! For some reason beyond my understanding, caching the filename made the trick...
  def filename(upload = file)
    @@_filename ||= lambda {
      if upload.present?
        current_filename =  upload.filename.match(/(.+)\.csv$/).captures.first
        "#{model.uuid}-#{current_filename}.csv"
      end
    }.call
  end
end
