class ShareableLink < ApplicationRecord
  belongs_to :album
  before_create :generate_token

  validates :expires_at, presence: true

  def expired?
    expires_at < Time.current
  end

  private

  def generate_token
    self.token = SecureRandom.hex(10)
  end
end
