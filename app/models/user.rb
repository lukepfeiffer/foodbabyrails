class User < ActiveRecord::Base
  include Authem::User
  before_create :confirm_token
  has_many :events
  has_many :votes
  validates_presence_of :email, :username

  def email_activate
    self.is_confirmed = true
    self.confirmation_token = nil
    save!(:validate => false)
  end

  private
  def confirm_token
    self.confirmation_token = SecureRandom.urlsafe_base64.to_s
  end
end
