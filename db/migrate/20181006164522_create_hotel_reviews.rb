class CreateHotelReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :hotel_reviews do |t|
      t.integer :hotel_id
      t.integer :user_id
      t.integer :review
      t.float :rate_avg, default: 0

      t.timestamps
    end
  end
end
