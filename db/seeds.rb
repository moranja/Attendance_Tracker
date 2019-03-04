require 'pry'

Student.destroy_all
SchoolDay.destroy_all
Attendance.destroy_all

CSV.foreach("csv_files/studentdb.csv") do |row|
  Student.create(full_name:row[0], pin_number: row[1])
end
