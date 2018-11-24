class Event < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates_presence_of :date, :time, :food_type, :address_line_one, :building_name, :room_number
  validate :check_valid_date

  def check_valid_date
    if date.present? && date < Date.today
      errors.add(:date, "Date must be today or after")
    end
  end
end
