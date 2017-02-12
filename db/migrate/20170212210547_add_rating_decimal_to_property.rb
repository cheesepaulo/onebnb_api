class AddRatingDecimalToProperty < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :rating, :decimal, :default => 0
  end
end
