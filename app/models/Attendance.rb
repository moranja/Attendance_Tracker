class Attendance < ActiveRecord::Base
 belongs_to :students
 belongs_to :school_days
end
