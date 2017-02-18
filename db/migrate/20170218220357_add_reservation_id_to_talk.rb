class AddReservationIdToTalk < ActiveRecord::Migration[5.0]
  def change
    add_column :talks, :reservation_id, :integer
  end
end
