class AddAuthorEmailToBook < ActiveRecord::Migration
  def change
    add_column :books, :author_email, :string
  end
end
