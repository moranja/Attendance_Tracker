class Student < ActiveRecord::Base
  has_many :attendances
  has_many :school_days, through: :attendances

  def sign_in
    Attendance.create(student: self,  school_day_id: School_Day.last.id, arrival_time: DateTime.now)
#School_Day.last , school_day: 'test'
  end
  #sign_in works if you say school_day_id: School_Day.last.id, but not if you write it
  #school_day: School_Day.last
end
