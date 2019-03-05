# require 'highline'
# require 'csv'
# require 'pry'

class Client < ActiveRecord::Base
cli = HighLine.new
#input = cli.ask "Enter Your PIN number"
result = Student.find_by!(pin_number: (cli.ask "Enter Your PIN number"))
binding.pry

0
end
=begin
x = []
CSV.foreach("../csv/studentdb.csv") do |row|
  if row.include?(input)
    x << row
  end
end
binding.pry
CSV.open("../csv/studentdb.csv") do |csv|
  csv.each do |row|
    if row.include?(input)
      x << row
    end
  end
end
=end
