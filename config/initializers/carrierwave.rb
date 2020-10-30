CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber?
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
    #
    # BooksImportUploader
    # CarrierWave::Uploader::Base.descendants.each do |klass|
    #   next if klass.anonymous?
    #   klass.class_eval do
    #     def cache_dir
    #       "#{Rails.root}/spec/support/uploads/tmp"
    #     end
    #
    #     def store_dir
    #       "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    #     end
    #   end
    # end
  else
    config.storage    = :aws
    config.aws_bucket = ENV.fetch('S3_BUCKET_NAME') # for AWS-side bucket access permissions config, see section below
    config.aws_acl    = 'private'

    # Optionally define an asset host for configurations that are fronted by a
    # content host, such as CloudFront.
    # config.asset_host = 'http://ondare.heroku.com'

    # The maximum period for authenticated_urls is only 7 days.
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

    # Set custom options such as cache control to leverage browser caching.
    # You can use either a static Hash or a Proc.
    config.aws_attributes = -> { {
        expires: 1.week.from_now.httpdate,
        cache_control: 'max-age=604800'
    } }

    config.aws_credentials = {
        access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
        secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
        region:            ENV.fetch('AWS_REGION'), # Required
        stub_responses:    Rails.env.test? # Optional, avoid hitting S3 actual during tests
    }
  end

  config.asset_host = ActionController::Base.asset_host
end