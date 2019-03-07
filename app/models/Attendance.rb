class Attendance < ActiveRecord::Base
 belongs_to :student
 belongs_to :school_day

 def is_early_or_late
   seconds_early = School_Day.current_day('09-00-00', self).to_i - self.arrival_time.in_time_zone("Central Time (US & Canada)").to_i
   if seconds_early > 0
     puts "you are #{Time.at(seconds_early).utc.strftime("%H:%M:%S")} early"
   elsif seconds_early < 0
     seconds_late = seconds_early * -1
     puts "you are #{Time.at(seconds_late).utc.strftime("%H:%M:%S")} late"
   end
   self.seconds_early = seconds_early
   self.save
 end


end
