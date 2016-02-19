class AddPolymorphicFieldsToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :picturable_id, :integer
    add_column :pictures, :picturable_type, :string
    remove_column :pictures, :book_id
  end
end
