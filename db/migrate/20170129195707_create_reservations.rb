class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.integer :property_id
      t.integer :user_id
      t.date :checkin_date
      t.date :checkout_date
      t.integer :status

      t.timestamps
    end
  end
end
