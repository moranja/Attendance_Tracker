require 'highline'
require 'csv'
require 'pry'
cli = HighLine.new
input = cli.ask "Enter Your PIN number"
x = []
CSV.foreach("../csv/studentdb.csv") do |row|
  if row.include?(input)
    x << row 
  end 
end
binding.pry
=begin
CSV.open("../csv/studentdb.csv") do |csv|
  csv.each do |row|
    if row.include?(input)
      x << row 
    end
  end
end
=end
