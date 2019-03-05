require_relative 'config/environment.rb'

cli = HighLine.new
#input = cli.ask "Enter Your PIN number"

$todays_date = DateTime.now.to_date.to_s

$today = School_Day.find_or_create_by(date: DateTime.now)

$student = Student.find_by!(pin_number: (cli.ask "Welcome back to Flation! Please enter your PIN number: "))
$student.sign_in
=begin
if $student.is_admin == false
puts "What would you like to do"
1-Sign in
$student.sign_in,
2-check attendance record
$student.check_attendance
3-log out
take you back to original menu
=end

$student.sign_in
puts "Hello #{$student.full_name} the time is: #{Attendance.last.arrival_time.to_time.strftime("%H:%M")}"

$student.check_my_attendance

HighLine::Menu.index_color = :rgb_999999
cli.choose do |menu|
  menu.prompt = "What would you like to do?"
  menu.choice(:attendance) {cli.say("Here is the attendance record for your class: #{Attendance.all}")}
  menu.choice(:student_attendance) {cli.say("Here is your attendance record: #{$student.attendance}")}
end
#retardsa

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