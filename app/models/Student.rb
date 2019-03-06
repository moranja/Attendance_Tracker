class Student < ActiveRecord::Base
  has_many :attendances
  has_many :school_days, through: :attendances

  def sign_in
    if self.attendances.last.is_current_day || nil
      puts "You've already logged your attendance today!"
    else
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
    absent_students = []
    late_students = []
    self.all.each do |student|
      if student.attendances.last.is_current_day != true && student.is_teacher == false
        absent_students << student.full_name
      elsif student.attendances.last.seconds_early < 0 && student.is_teacher == false
        late_students << student.full_name
      end
    end

    if late_students == [] && absent_students == []
      puts "Everyone was here on time today!"
    elsif late_students != []
      puts "Here's who was late today:"
      puts late_students
    elsif absent_students != []
      puts "Here's who is absent today:"
      puts absent_students
    end
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
    if castaway.is_teacher == true
      puts "That's not a student, that's a teacher!"
    else
      castaway.delete
      puts "Deleted Student: #{student_name}"
    end
  end

  def delete_teacher(student_name)
    castaway = Student.find_by full_name: student_name
    if castaway.is_teacher == false
      puts "That's not a teacher, that's a student!"
    elsif castaway = self
      puts "You can't delete yourself!"
    else
      castaway.delete
      puts "Deleted Teacher: #{student_name}"
    end
  end

  def check_if_teacher
    if self.is_teacher == true
      puts "Welcome, to the teacher menu!"
      return "Teacher"
    else
      puts "You're not a teacher!"
    end
  end

  def self.create_student(deets)
    deets_array = deets.split(', ')
    Student.create(full_name: deets_array[0], pin_number: deets_array[1].to_i, is_teacher: false)
  end

  def self.create_teacher(deets)
    deets_array = deets.split(', ')
    Student.create(full_name: deets_array[0], pin_number: deets_array[1].to_i, is_teacher: true)
  end

  def change_pin_number(int_in_a_string)
    if int_in_a_string.to_i.digits.count != 8
      puts "The new pin number was not an 8 digit number, please try again!"
    else
      puts "Your pin number has been changed to #{int_in_a_string.to_i}"
      self.pin_number = int_in_a_string.to_i
      self.save
    end
  end



end
