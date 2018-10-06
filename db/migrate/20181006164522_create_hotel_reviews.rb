class CreateHotelReviews < ActiveRecord::Migration
  def change
    create_table :hotel_reviews do |t|
      t.integer :hotel_id
      t.integer :user_id
      t.string :review

      t.timestamps
    end
  end
end
