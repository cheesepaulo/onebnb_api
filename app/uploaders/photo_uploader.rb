class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave unless Rails.env.test?
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  version :thumb do
    process resize_to_fit: [50, 50]
  end
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
