require_relative 'config/environment.rb'

cli = HighLine.new
#input = cli.ask "Enter Your PIN number"

$todays_date = DateTime.now.to_date.to_s

$today = School_Day.find_or_create_by(date: $todays_date)

$student = Student.find_by!(pin_number: (cli.ask "Enter Your PIN number"))

#binding.pry

$student.sign_in

#Attendance.new(student: $student, school_day: School_Day.last, arrival_time: DateTime.now, manually_changed: false)





Pry.start





=begin
x = []
CSV.foreach("../csv/studentdb.csv") do |row|
  if row.include?(input)
    x << row
  end
end
binding.pry
CSV.open("../csv/studentdb.csv") do |csv|
  csv.each do |row|
    if row.include?(input)
      x << row
    end
  end
end
=end
