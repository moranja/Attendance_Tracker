class School_Day < ActiveRecord::Base
  has_many :attendances
  has_many :students, through: :attendances

  def self.current_day(hh_mm_ss, att)
    c_d = att.arrival_time.to_date
    hms = hh_mm_ss.split('-')
    fixing_hour = hms[0].to_i + 6
    hms[0] = fixing_hour.to_s
    DateTime.new(c_d.year, c_d.month, c_d.day,hms[0].to_i,hms[1].to_i,hms[2].to_i).in_time_zone("Central Time (US & Canada)")
  end
end
