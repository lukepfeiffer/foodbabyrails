class User < ActiveRecord::Base
  include Authem::User
  before_create :confirm_token
  has_many :events
  has_many :votes

  validates_presence_of :email, :username
  validates_uniqueness_of :username
  validates :email, format: {
                              with: /\b[A-Z0-9._%a-z\-]+@ufl\.edu\z/,
                              message: "Must be an @ufl.edu account"
                            }


  def email_activate
    self.is_confirmed = true
    self.confirmation_token = nil
    save!(:validate => false)
  end

  private
  def confirm_token
    require 'pry'; binding.pry
    self.confirmation_token = SecureRandom.urlsafe_base64.to_s
  end
end
