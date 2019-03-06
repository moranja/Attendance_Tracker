require_relative 'config/environment.rb'

@cli = HighLine.new

def clear_logs
  system "clear"
end

def make_the_current_day
  School_Day.find_or_create_by(date: DateTime.now)
end

def ask_the_student_to_log_in
  result = Student.find_by(pin_number: (@cli.ask "Welcome back to Flation! Please enter your PIN number: "))
  while result == nil
    result = Student.find_by(pin_number: (@cli.ask "No Student found with that pin number, please enter your pin number: "))
  end
  result
end

def greet_student(student)
  puts "Hello #{student.full_name}, the time is: #{DateTime.now.in_time_zone("Central Time (US & Canada)").to_time.strftime("%H:%M")}"
end

def start_menu(student)
  HighLine::Menu.index_color = :rgb_999999
  @cli.choose do |menu|
    menu.prompt = "What would you like to do?"
    menu.choice("Log attendance for today") {clear_logs && student.sign_in}
    menu.choice("Change arrival time for today") {clear_logs && student.change_arrival_time(@cli.ask "Please enter the time you arrived (in format HH-MM):")}
    menu.choice("Check my attendance") {clear_logs && student.check_my_attendance(@cli.ask "How many days would you like to see?")}
    menu.choice("See attendance of whole class") {clear_logs && @cli.say("Here is the attendance record for your class: #{Attendance.all}")}
    menu.choice("See who's late today") {clear_logs && @cli.say("Here is who was late today: #{Student.who_is_late}")}
    menu.choice("Exit") {return "Exit"}
  end
end

############################################
#### Start the real program here ###########
############################################



make_the_current_day
current_student = ask_the_student_to_log_in
greet_student(current_student)

return_value = ''
while return_value != "Exit"
  return_value = start_menu(current_student)
end



#Pry.start



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
