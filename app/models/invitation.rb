class Invitation < ActiveRecord::Base

  before_create :generate_token

  validates :invitation_email, presence: true, email: true

  private

  def generate_token
    self.token = SecureRandom.hex(16) unless token.present?
  end
end