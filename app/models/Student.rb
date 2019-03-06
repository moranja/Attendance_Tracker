class Student < ActiveRecord::Base
  has_many :attendances
  has_many :school_days, through: :attendances

  def sign_in
    if self.attendances.last.arrival_time.to_date == DateTime.now.to_date || nil
      puts "You've already logged your attendance today!"
    else self.attendances.last.arrival_time.to_date == DateTime.now.to_date
      todays_attendance = Attendance.create(student: self,  school_day_id: School_Day.last.id, manually_changed: false, arrival_time: DateTime.now.in_time_zone("Central Time (US & Canada)"))
      todays_attendance.is_early_or_late
    end
  end
  #sign_in works if you say school_day_id: School_Day.last.id, but not if you write it
  #school_day: School_Day.last

  def check_my_attendance
    self.attendances.last(5).each do |att|
      puts "On #{att.arrival_time.to_date} you got here at #{att.arrival_time.to_time.strftime("%H:%M")}."
    end
  end

  def self.who_is_late
    self.all.select {|student| student.attendances.last.minutes_early < 0}
  end

  def change_arrival_time(hh_mm)
    new_time = (hh_mm.split("-") << '00').join('-')
    todays_attendance = self.attendances.last
    todays_attendance.arrival_time = School_Day.today(new_time).in_time_zone("Central Time (US & Canada)")
    todays_attendance.is_early_or_late
    todays_attendance.manually_changed = true
  end
end
