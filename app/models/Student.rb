class Student < ActiveRecord::Base
  has_many :attendances
  has_many :school_days, through: :attendances

end
