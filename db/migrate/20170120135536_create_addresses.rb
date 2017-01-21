class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :neighborhood
      t.string :street
      t.string :number
      t.string :zipcode
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
