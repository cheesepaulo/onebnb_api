class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.integer :user_id
      t.integer :property_id

      t.timestamps
    end
  end
end
