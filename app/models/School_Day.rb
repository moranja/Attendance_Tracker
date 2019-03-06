class School_Day < ActiveRecord::Base
  has_many :attendances
  has_many :students, through: :attendances

  def self.today(hh_mm_ss)
    today = School_Day.last
    hms = hh_mm_ss.split('-')
    DateTime.new(today.date.year, today.date.month, today.date.day,hms[0].to_i,hms[1].to_i,hms[2].to_i).in_time_zone("Central Time (US & Canada)")
  end

end
