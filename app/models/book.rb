class Book < ActiveRecord::Base
  validates :name, :author, :description, :slug, presence: true
  validates :slug, uniqueness: true
end
