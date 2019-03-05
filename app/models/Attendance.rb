class Attendance < ActiveRecord::Base
 belongs_to :student
 belongs_to :school_day
end
