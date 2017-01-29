class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :property_id
      t.integer :status

      t.timestamps
    end
  end
end
