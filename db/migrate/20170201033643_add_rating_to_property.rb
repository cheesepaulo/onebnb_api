class AddRatingToProperty < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :rating, :integer, :default => 0
  end
end
