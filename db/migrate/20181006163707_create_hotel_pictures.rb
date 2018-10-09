class CreateHotelPictures < ActiveRecord::Migration
  def change
    create_table :hotel_pictures do |t|
      t.integer :hotel_id
      t.string :picture

      t.timestamps
    end
  end
end
