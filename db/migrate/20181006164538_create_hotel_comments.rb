class CreateHotelComments < ActiveRecord::Migration
  def change
    create_table :hotel_comments do |t|
      t.integer :hotel_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end
