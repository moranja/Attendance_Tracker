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

  def check_my_attendance (num_of_days)
    how_early = 0
    self.attendances.last(num_of_days.to_i).each do |att|
      puts "On #{att.arrival_time.to_date} you got here at #{att.arrival_time.to_time.strftime("%H:%M")}."
      how_early += att.seconds_early
    end
    how_early /= num_of_days.to_i
    if how_early > 600
      puts "Great job, early bird!"
    elsif how_early < 0
      puts "You need to work on your punctuality!"
    else
      puts "You're cutting it close...."
    end
  end

  def self.who_is_late
    self.all.select {|student| student.attendances.last.seconds_early < 0}
  end

  def change_arrival_time(hh_mm)
    new_time = (hh_mm.split("-") << '00').join('-')
    todays_attendance = self.attendances.last
    todays_attendance.arrival_time = School_Day.today(new_time).in_time_zone("Central Time (US & Canada)")
    todays_attendance.is_early_or_late
    todays_attendance.manually_changed = true
    todays_attendance.save
  end

  def self.is_earliest
    earliest = 0
    early_bird = ' '
    self.all.each do |student|
      if student.attendances.seconds_early > earliest
        earliest = student.attendances.seconds_early
        early_bird = student.full_name
      end
    end
    early_bird
  end

  def self.delete_student(student_name)
    castaway = Student.find_by full_name: student_name
    castaway.delete
    puts "Deleted Student: #{student_name}"
    return "Teacher"
  end

  def check_if_teacher
    if self.is_teacher == true
      puts "Welcome, to the teacher menu!"
      return "Teacher"
    else
      puts "You're not a teacher!"
    end
  end

  def self.create_student(full_name, pin_number, is_teacher)
    Student.create(full_name: full_name, pin_number: pin_number.to_i, is_teacher: false)
  end


end
