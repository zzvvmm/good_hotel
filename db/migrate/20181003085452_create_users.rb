class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :picture
      t.string :password_digest
      t.integer :role, default: 1

      t.timestamps
    end
  end
end