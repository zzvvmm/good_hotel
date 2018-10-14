class User < ActiveRecord::Base
  has_many :hote_reviews, dependent: :destroy
end
