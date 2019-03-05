require_relative 'config/environment.rb'

@cli = HighLine.new

def make_the_current_day
  School_Day.find_or_create_by(date: DateTime.now)
end

def ask_the_student_to_log_in
  $student = Student.find_by!(pin_number: (@cli.ask "Welcome back to Flation! Please enter your PIN number: "))
end

def greet_student
  puts "Hello #{$student.full_name}, the time is: #{Attendance.last.arrival_time.to_time.strftime("%H:%M")}"
end

def start_menu
  HighLine::Menu.index_color = :rgb_999999
  @cli.choose do |menu|
    menu.prompt = "What would you like to do?"
    menu.choice("Log attendance for today") {$student.sign_in}
    menu.choice("Change arrival time for today") #$student.change_arrival_time
    menu.choice("Check my attendance") {@cli.say("Here is your attendance record: #{$student.check_my_attendance}")}
    menu.choice("See attendance of whole class") {@cli.say("Here is the attendance record for your class: #{Attendance.all}")}
    menu.choice("Exit") {break}
  end
end

############################################
#### Start the real program here ###########
############################################

make_the_current_day
ask_the_student_to_log_in
greet_student
while 1!=0
  start_menu
end




Pry.start



#$student.sign_in
#$student.check_my_attendance


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
