require 'carrierwave/orm/activerecord'

class BooksImportUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def store_path(for_file = filename)
    "uploads/#{Rails.env}/#{model.class.to_s.underscore.pluralize}/#{mounted_as}/#{model.id}/#{for_file}"
  end

  def filename(uploaded_file = file)
    if uploaded_file.present?
      "#{model.uuid}-#{uploaded_file.filename}"
    end
  end
end
