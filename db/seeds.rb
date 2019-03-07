require 'pry'

Student.destroy_all
School_Day.destroy_all
Attendance.destroy_all


CSV.foreach("csv/past_attendance.csv", :headers => true) do |row|
  current_student = ''
  row.each do |header, value|
    if header == "NAME"
      current_student = Student.create(full_name: value, pin_number: 12345678, is_teacher: false)
    elsif header == nil
    elsif header == "BIRTHDAY"
      current_student.update(pin_number: value)
    else
      date = header.split(' ').pop
      date_array = date.split('/')
      int_date_array = date_array.map {|x| x.to_i}
      int_date_array[2] += 2000
      # ^-- converts date to correct format
      time = value.split(' ').shift
      time_array = time.split(':')
      int_time_array = time_array.map {|x| x.to_i}
      int_time_array[0] += 6
      # ^-- converts time to correct format
      current_day = School_Day.find_or_create_by(date: DateTime.new(int_date_array[2],int_date_array[0],int_date_array[1],9,0,0).to_date.to_s)
      new_a = Attendance.create(student: current_student, school_day_id: current_day.id, arrival_time:DateTime.new(int_date_array[2],int_date_array[0],int_date_array[1],int_time_array[0],int_time_array[1],0), manually_changed:false)
      new_a.is_early_or_late
      new_a.save
    end
  end
end
fix_adam = Student.find_by(full_name: 'Adam Moran')
fix_adam.pin_number = '99999999'
fix_adam.save

Student.create(full_name: 'Alan Hong',pin_number: '11111111'.to_i,is_teacher: true) #05171984
Student.create(full_name: 'Joshua Miles',pin_number: '11041997'.to_i,is_teacher: true)
