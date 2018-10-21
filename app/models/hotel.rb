class Hotel < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_hotel_name, against: [:name],
    using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}}
  has_many :hotel_reviews
  has_many :comments, as: :commentable, dependent: :destroy

end
