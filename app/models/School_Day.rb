class SchoolDay < ActiveRecord::Base
  has_many :attendances
  has_many :students, through: :attendances

end
