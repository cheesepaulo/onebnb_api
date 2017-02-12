class AddGenderToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :description, :text
    add_column :users, :phone, :string
    add_column :users, :gender, :integer
    add_column :users, :birthday, :date
  end
end
