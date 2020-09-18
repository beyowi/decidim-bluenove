require "carrierwave/storage/fog"

# frozen_string_literal: true

# Default CarrierWave setup.
#
# CarrierWave.configure do |config|
#   config.permissions = 0o666
#   config.directory_permissions = 0o777
#   config.storage = :file
#   config.enable_processing = !Rails.env.test?
# end

# Setup CarrierWave to use Amazon S3. Add `gem "fog-aws" to your Gemfile.
#
# CarrierWave.configure do |config|
#   config.storage = :fog
#   config.fog_provider = 'fog/aws'                                             # required
#   config.fog_credentials = {
#     provider:              'AWS',                                             # required
#     aws_access_key_id:     Rails.application.secrets.aws_access_key_id,     # required
#     aws_secret_access_key: Rails.application.secrets.aws_secret_access_key, # required
#     region:                'eu-west-1',                                       # optional, defaults to 'us-east-1'
#     host:                  's3.example.com',                                  # optional, defaults to nil
#     endpoint:              'https://s3.example.com:8080'                      # optional, defaults to nil
#   }
#   config.fog_directory  = 'name_of_directory'                                 # required
#   config.fog_public     = false                                               # optional, defaults to true
#   config.fog_attributes = {
#     'Cache-Control' => "max-age=#{365.day.to_i}",
#     'X-Content-Type-Options' => "nosniff"
#   }
# end

CarrierWave.configure do |config|
  if Rails.env.prod?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['DO_KEY'],
      :aws_secret_access_key  => ENV['DO_SECRET'],
      :region                 => ENV['DO_REGION'],
      :host               => ENV['DO_HOST'],
      :endpoint               => ENV['DO_ENDPOINT']
    }
    config.fog_directory  = ENV['DO_BUCKET']
    config.fog_public = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}", 'X-Content-Type-Options' => "nosniff"}
    config.enable_processing = true
  else
    config.permissions = 0o666
    config.directory_permissions = 0o777
    config.storage = :file
    config.enable_processing = !Rails.env.test?
  end
end