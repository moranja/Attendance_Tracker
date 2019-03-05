require 'pry'

Student.destroy_all
School_Day.destroy_all
Attendance.destroy_all

CSV.foreach("csv/studentdb.csv") do |row|
  Student.create(full_name:row[0], pin_number: row[1])
end

School_Day.create(date: DateTime.new(2019,3,4,15,0,0).to_date.to_s)
#Attendance.create
Attendance.create(student: Student.find_by(full_name: 'Adam Moran'), school_day_id: School_Day.last.id, arrival_time: DateTime.new(2019,3,4,9,0,0))
