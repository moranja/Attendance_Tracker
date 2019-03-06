class Student < ActiveRecord::Base
  has_many :attendances
  has_many :school_days, through: :attendances

  def sign_in
    if self.attendances.last.arrival_time.to_date == DateTime.now.to_date || nil
      puts "You've already logged your attendance today!"
    else self.attendances.last.arrival_time.to_date == DateTime.now.to_date
      seconds_early = School_Day.today('15-00-00').to_i - DateTime.now.to_i
      if seconds_early > 0
        puts "you are #{time_early = Time.at(seconds_early).utc.strftime("%H:%M:%S")} early"
      elsif seconds_early < 0
        seconds_late = seconds_early * -1
        puts "you are #{time_early = Time.at(seconds_late).utc.strftime("%H:%M:%S")} late"
      end
      minutes_early = seconds_early/60
      #I think we should turn this whole "seconds_early thing into its own method, and change the minutes early column in Attendance into seconds early."
      Attendance.create(student: self,  school_day_id: School_Day.last.id, arrival_time: DateTime.now, minutes_early: minutes_early)
      #If we do that, then we should take seconds_early out of the initalize call here, and call the method afterward (which will calculate and set the seconds early) (See change_arrival_time method for more)
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
    self.attendances.last.arrival_time = School_Day.today(new_time)
    #Then, we could just call it again any time we change the arrival time
    self.attendances.last.manually_changed = true
  end
end
