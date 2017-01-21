class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.decimal :price
      t.string :name
      t.text :description
      t.references :user, foreign_key: true
      t.integer :accommodation_type
      t.integer :guest_max
      t.integer :beds
      t.integer :bedroom
      t.references :address, foreign_key: true
      t.integer :status
      t.references :facility, foreign_key: true
      t.integer :bathroom

      t.timestamps
    end
  end
end
