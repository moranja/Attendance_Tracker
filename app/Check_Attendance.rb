require_relative '../config/environment.rb'

class Testing
cli = HighLine.new
#input = cli.ask "Enter Your PIN number"

todays_date = DateTime.now.to_date.to_s
#result = Student.find_by!(pin_number: (cli.ask "Enter Your PIN number"))

today = SchoolDay.find_or_create_by(date: DateTime.now.to_date.to_s)




test22 = 0






Pry.start

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
