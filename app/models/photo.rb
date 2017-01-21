class Photo < ApplicationRecord
  belongs_to :property
  mount_base64_uploader :photo, PhotoUploader
end
