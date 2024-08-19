class Photo < ApplicationRecord
  belongs_to :album
  validates :image, presence: true
end
