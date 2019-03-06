require_relative 'config/environment.rb'

@cli = HighLine.new

def clear_logs
  system "clear"
end

def random_color
  
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
    menu.choice("See Teacher Options") {clear_logs && student.check_if_teacher}
    menu.choice("Exit") {return "Exit"}
  end
end

def teacher_menu(student)
  HighLine::Menu.index_color = :rgb_999999
  @cli.choose do |menu|
    menu.prompt = "What would you like to do?".colorize(:background => :green)
    menu.choice("Log attendance for today".colorize(:background => :blue)) {clear_logs && student.sign_in}

    menu.choice("Change arrival time for today".colorize(:background => :purple)) {clear_logs && student.change_arrival_time(@cli.ask "Please enter the time you arrived (in format HH-MM):".colorize(:background => :yellow))}

    menu.choice("Check my attendance".colorize(:background => :pink)) {clear_logs && student.check_my_attendance(@cli.ask "How many days would you like to see?".colorize(:background => :light_blue))}

    menu.choice("See attendance of whole class".colorize(:background => :red)) {clear_logs && @cli.say("Here is the attendance record for your class: #{Attendance.all}")}

    menu.choice("See who's late today".colorize(:background => :grey)) {clear_logs && @cli.say("Here is who was late today: #{Student.who_is_late}")}

    menu.choice("Add a student") {clear_logs && Student.create_student(@cli.ask "Enter full name and pin_number of student to be created (in format 'Adam Moran, 12345678'):")}

    menu.choice("Add a teacher") {clear_logs && Student.create_teacher(@cli.ask "Enter full name and pin_number of teacher to be created (in format 'Joshua Miles, 12345678'):")}

    menu.choice("Remove a student") {clear_logs && Student.delete_student(@cli.ask "Enter full name of student to be deleted:")}

    menu.choice("Remove a teacher") {clear_logs && student.delete_teacher(@cli.ask "Enter full name of student to be deleted:")}

    menu.choice("Change my pin number") {clear_logs && student.change_pin_number(@cli.ask "Enter an eight digit number:")}

    menu.choice("Exit") {return "Exit"}
  end
end

# menu.choice("See attendance of whole class") {clear_logs && @cli.say("Here is the attendance record for your class: #{Attendance.all}")}
# menu.choice("See who's late today") {clear_logs && @cli.say("Here is who was late today: #{Student.who_is_late}")}

############################################
#### Start the real program here ###########
############################################



make_the_current_day
clear_logs && current_student = ask_the_student_to_log_in
clear_logs && greet_student(current_student)

return_value = ''
while return_value != "Exit" && return_value != "Teacher"
  return_value = start_menu(current_student)
end

if return_value == "Teacher"
  while return_value != "Exit"
    return_value = teacher_menu(current_student)
  end
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
