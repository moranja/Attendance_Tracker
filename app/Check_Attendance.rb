require 'pry'
require 'highline'

cli = HighLine.new
input = cli.ask "Enter your PIN number"
if input == "1234"
  puts "Swagger"
else
  puts "Not Swagger"
end
