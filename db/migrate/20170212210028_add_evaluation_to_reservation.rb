class AddEvaluationToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :evaluation, :boolean
  end
end
