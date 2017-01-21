class CreateFacilities < ActiveRecord::Migration[5.0]
  def change
    create_table :facilities do |t|
      t.boolean :wifi
      t.boolean :washing_machine
      t.boolean :clothes_iron
      t.boolean :towels
      t.boolean :air_conditioning
      t.boolean :heater
      t.boolean :refrigerator

      t.timestamps
    end
  end
end
