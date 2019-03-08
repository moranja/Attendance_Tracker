require_relative 'config/environment.rb'

@cli = HighLine.new

def clear_logs
  system "clear"
end

def make_the_current_day
  School_Day.find_or_create_by(date: DateTime.now)
end # Currently we have no functionality built in to account for students who are absent, except teachers logging in as them and setting their arrival time to 6:00 PM or something. It'd be cool if when this ran it checked for all attendances the past day and made up absences if there's an empty entry.

def ask_the_student_to_log_in
  result = Student.find_by(pin_number: (@cli.ask "Welcome back to Flatiron! Please enter your PIN number: "))
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
    menu.choice("Check my attendance") {clear_logs && student.check_my_attendance(@cli.ask "How many days would you like to see? (Enter '-1' for all)")}
    menu.choice("Check how much class time I've missed") {clear_logs && student.total_class_missed}
    menu.choice("Exit") {return "Exit"}
  end
end

def teacher_menu(student)
  HighLine::Menu.index_color = :rgb_999999
  @cli.choose do |menu|
    menu.prompt = "What would you like to do?".colorize(:background => :green)
    menu.choice("Export attendance to .csv file".colorize(:background => :light_blue)) {clear_logs && Attendance.export_attendance_sheet(@cli.ask("Enter file name for output: (do not include .csv)"))}
    menu.choice("See who's late today".colorize(:background => :yellow)) {clear_logs && Student.who_is_late}
    menu.choice("Login as a student") {clear_logs && menu(Student.find_by(full_name: (@cli.ask "Enter full name of student to log in as (e.g. Adam Moran):")))}
    menu.choice("Add a student".colorize(:background => :light_green)) {clear_logs && Student.create_student_or_teacher((@cli.ask "Enter full name and pin_number of student to be created (in format 'Adam Moran, 12345678'):"),'student')}
    menu.choice("Add a teacher".colorize(:background => :green)) {clear_logs && Student.create_student_or_teacher((@cli.ask "Enter full name and pin_number of teacher to be created (in format 'Joshua Miles, 12345678'):"),'teacher')}
    menu.choice("Remove a student".colorize(:background => :light_red)) {clear_logs && Student.delete_student(@cli.ask "Enter full name of student to be deleted:")}
    menu.choice("Remove a teacher".colorize(:background => :blue)) {clear_logs && student.delete_teacher(@cli.ask "Enter full name of teacher to be deleted:")}
    menu.choice("Change my pin number".colorize(:background => :cyan)) {clear_logs && student.change_pin_number(@cli.ask "Enter an eight digit number:")}
    menu.choice("Exit".colorize(:background => :red)) {return "Exit"}
  end
end

def menu (current_student)
  return_value = ''
  if current_student == nil
    puts "Whoops, I couldn't find that student..."
  elsif current_student.is_teacher
    while return_value != "Exit"
      return_value = teacher_menu(current_student)
    end
  else
    while return_value != "Exit" && return_value != "Teacher"
      return_value = start_menu(current_student)
    end
  end
end

############################################
#### Start the real program here ###########
############################################

make_the_current_day
clear_logs && current_student = ask_the_student_to_log_in
clear_logs && greet_student(current_student)
menu(current_student)

#Pry.start
