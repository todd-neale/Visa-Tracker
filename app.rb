require 'date'

class VisaTracker
  def initialize
    @total_days = 90
    @holidays = []
  end
  
  def add_holiday(location, arrival_date, departure_date)
    holiday = {
      location: location,
      arrival_date: arrival_date,
      departure_date: departure_date
    }
    @holidays << holiday
    update_remaining_days
  end
  
  def view_holidays
    puts "Your Holidays:"
    @holidays.each_with_index do |holiday, index|
      puts "#{index + 1}. #{holiday[:location]} (#{holiday[:arrival_date]} - #{holiday[:departure_date]})"
    end
    puts ""
  end
  
  def update_remaining_days
    days_spent = 0
    @holidays.each do |holiday|
      days_spent += (holiday[:departure_date] - holiday[:arrival_date]).to_i + 1
    end
    @total_days -= days_spent
  end

  def view_remaining_days
    puts "You have #{@total_days} days of your Schengen visa remaining."
  end

  def view_final_date
    puts "The final day you can be in the EU is #{Date.today + @total_days}"
  end
end

visa_tracker = VisaTracker.new

loop do
  puts "What would you like to do?"
  puts "1. Add a holiday"
  puts "2. View holidays"
  puts "3. View remaining visa days"
  puts "4. Exit"
  input = gets.chomp.to_i
  
  case input
  when 1
    puts "Enter the location of your holiday:"
    location = gets.chomp
    puts "Enter the arrival date of your holiday (YYYY-MM-DD):"
    arrival_date = Date.parse(gets.chomp)
    puts "Enter the departure date of your holiday (YYYY-MM-DD):"
    departure_date = Date.parse(gets.chomp)
    visa_tracker.add_holiday(location, arrival_date, departure_date)
  when 2
    visa_tracker.view_holidays
  when 3
    visa_tracker.view_remaining_days
    visa_tracker.view_final_date
  when 4
    break
  else
    puts "Invalid input. Please try again."
  end
end
