class Album < ApplicationRecord
  has_many :photos, dependent: :destroy
  validates :name, presence: true

  before_save :generate_slug

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.parameterize if slug.blank?
  end
end
