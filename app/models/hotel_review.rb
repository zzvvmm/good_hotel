class HotelReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :hotel

  validates :review, presence: true

  scope :order_by_time, ->{order created_at: :desc}

end
