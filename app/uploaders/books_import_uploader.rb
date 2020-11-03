require 'carrierwave/orm/activerecord'

class BooksImportUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore.pluralize}/#{mounted_as}/#{model.id}"
  end

  def store_path(for_file = filename)
    "uploads/#{Rails.env}/#{model.class.to_s.underscore.pluralize}/#{mounted_as}/#{model.id}/#{for_file}"
  end


  #
  # TODO: For some reason S3 stops accepting the files when I try to overwrite the file name
  # def filename(upload = file)
  #   "#{model.uuid}-#{upload&.filename}"
  # end
end
