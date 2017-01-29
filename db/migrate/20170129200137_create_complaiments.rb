class CreateComplaiments < ActiveRecord::Migration[5.0]
  def change
    create_table :complaiments do |t|
      t.text :body
      t.integer :property_id
      t.integer :user_id

      t.timestamps
    end
  end
end
