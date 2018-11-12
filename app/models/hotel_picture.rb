class HotelPicture < ApplicationRecord
  mount_uploader :picture, PictureUploader
end
