class Book < ActiveRecord::Base
  validates :name, :author, :description, :slug, presence: true
  validates :slug, uniqueness: true

  has_many :comments
  has_many :pictures, as: :picturable
  before_save :verify_slug_field
  before_destroy :verify_if_can_be_destroyed

  private

  def verify_slug_field
    self.slug = slug.gsub("_", "")
  end

  def verify_if_can_be_destroyed
    return !(comments.count >= 1)
  end
end
