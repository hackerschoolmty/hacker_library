class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :book_id
      t.integer :user_id
      t.string :description

      t.timestamps null: false
    end
  end
end
