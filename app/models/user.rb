class User < ActiveRecord::Base
  include Authem::User
  has_many :events
  has_many :votes
end
