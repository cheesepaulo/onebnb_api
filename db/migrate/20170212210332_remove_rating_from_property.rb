class RemoveRatingFromProperty < ActiveRecord::Migration[5.0]
  def change
    remove_column :properties, :rating, :string
  end
end
