class Student < ActiveRecord::Base
  has_many :attendances
  has_many :school_days, through: :attendances

  def sign_in
    if self.attendances.last.arrival_time.to_date == DateTime.now.to_date || nil
      puts "You've already logged your attendance today!"
    else self.attendances.last.arrival_time.to_date == DateTime.now.to_date
      datetime_now = DateTime.now
      today = School_Day.last
      today_at_nine = DateTime.new(today.date.year, today.date.month, today.date.day,15,0,0)
      seconds_early = today_at_nine.to_i - datetime_now.to_i
      if seconds_early > 0
        puts "you are #{time_early = Time.at(seconds_early).utc.strftime("%H:%M:%S")} early"
      elsif seconds_early < 0
        seconds_late = seconds_early * -1
        puts "you are #{time_early = Time.at(seconds_late).utc.strftime("%H:%M:%S")} late"
      end
      minutes_early = seconds_early/60

      Attendance.create(student: self,  school_day_id: School_Day.last.id, arrival_time: datetime_now, minutes_early: minutes_early)
      #binding.pry
    end
  end
  #sign_in works if you say school_day_id: School_Day.last.id, but not if you write it
  #school_day: School_Day.last

  def check_my_attendance
    self.attendances.last(5).each do |att|
      puts "On #{att.arrival_time.to_date} you got here at #{att.arrival_time.to_time.strftime("%H:%M")}."
    end
  end

end
