class Student < ActiveRecord::Base
  has_many :attendances
  has_many :school_days, through: :attendances

  def sign_in
    Attendance.new(user_id: self, school_day_id: School_Day.last, arrival_time: DateTime.now, manually_changed: false)
  end
end
