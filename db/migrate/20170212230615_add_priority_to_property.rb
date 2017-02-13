class AddPriorityToProperty < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :priority, :boolean
  end
end
