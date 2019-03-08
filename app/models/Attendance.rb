class Attendance < ActiveRecord::Base
 belongs_to :student
 belongs_to :school_day

 def is_early_or_late
   seconds_early = School_Day.current_day('09-00-00', self).to_i - self.arrival_time.in_time_zone("Central Time (US & Canada)").to_i
   if seconds_early > 0
     puts "you were #{Time.at(seconds_early).utc.strftime("%H:%M:%S")} early"
   elsif seconds_early < 0
     seconds_late = seconds_early * -1
     puts "you were #{Time.at(seconds_late).utc.strftime("%H:%M:%S")} late"
   end
   self.seconds_early = seconds_early
   self.save
 end

 def self.export_attendance_sheet(file_name)
   CSV.open("csv/#{file_name}.csv", "w+") do |csv|
     title_row = School_Day.all.map {|sd| sd.date}
     title_row.unshift("Students")
     csv << title_row
     Student.find_each do |student|
       if student.is_teacher
       else
         array_test = student.attendances.map {|x| x.arrival_time.in_time_zone("Central Time (US & Canada)")}
         array_test.unshift(student.full_name)
         csv << array_test
       end
     end
   end
 end
end
