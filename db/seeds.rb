require 'pry'

Student.destroy_all
School_Day.destroy_all
Attendance.destroy_all

CSV.foreach("csv/studentdb.csv") do |row|
  Student.create(full_name:row[0], pin_number: row[1], is_teacher: false)
end

Student.create(full_name: 'Alan Hong',pin_number: '11111111'.to_i,is_teacher: true) #05171984
Student.create(full_name: 'Joshua Miles',pin_number: '11041997'.to_i,is_teacher: true)

School_Day.create(date: DateTime.new(2019,3,5,9,0,0).in_time_zone("Central Time (US & Canada)").to_date.to_s)
#Attendance.create
#Attendance.create(student: Student.find_by(full_name: 'Adam Moran'), school_day_id: School_Day.last.id, arrival_time: DateTime.new(2019,3,4,15,0,0), minutes_early: 0)

Student.all.each do |student|
  new_a = Attendance.create(student: student, school_day_id: School_Day.last.id, arrival_time: DateTime.new(2019,3,5,14,45,0).in_time_zone("Central Time (US & Canada)"), manually_changed: false)
  new_a.is_early_or_late
  new_a.save
end
