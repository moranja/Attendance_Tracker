require_relative 'config/environment.rb'

@cli = HighLine.new


def make_the_current_day
  School_Day.find_or_create_by(date: DateTime.now)
end

def ask_the_student_to_log_in
  result = Student.find_by(pin_number: (@cli.ask "Pin?"), is_teacher: false)
  while result == nil
    puts "Error"
    result = Student.find_by(pin_number: (@cli.ask "Pin?"), is_teacher: false)
  end
  result
end

####################
result = ''
while result != 'Exit'
  make_the_current_day
  current_student = ask_the_student_to_log_in
  current_student.sign_in
end
