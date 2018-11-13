class Hotel < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_hotel_name, against: [:name],
    using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}}
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :hotel_pictures
  ratyrate_rateable "quality"
  has_many :rating_averages, class_name: :RatingCache, foreign_key: :cacheable_id do
    def with_dimension(dimension)
      where dimension: dimension
    end
  end


  def self.filter_by_service(params)
    services = params.keys & ["wifi", "pool", "breakfast", "parking"]
    hotels = Hotel.all
    services.each do |service|
      hotels = hotels.where(service, true)
    end
    if (params.include? "star") && (params[:star].to_i >=1) && (params[:star].to_i <=5)
      hotels = hotels.where(rate_round: params[:star])
    end
    return hotels
  end
end
