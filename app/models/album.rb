class Album < ApplicationRecord
  has_many :photos, dependent: :destroy
  has_many :shareable_links, dependent: :destroy
  has_secure_password validations: false
  validates :name, presence: true
  validates :password, presence: true, if: :private?

  before_save :generate_slug

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.parameterize if slug.blank?
  end
end
