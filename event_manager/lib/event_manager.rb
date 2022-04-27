require "csv"
require "google/apis/civicinfo_v2"
require "erb"
require "time"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone(phone_number)
  phone_number_all_numbers = phone_number.gsub(/\D/, "")
  p phone_number_all_numbers
  if (phone_number_all_numbers.length == 10)
  elsif (phone_number_all_numbers.length == 11 && phone_number_all_numbers[0] == "1")
    phone_number_all_numbers = phone_number_all_numbers[1..-1]
  else
    phone_number_all_numbers = "0000000000"
  end
  phone_number_all_numbers
end

def get_popular_hour(contents)
  day_count = Array.new(25, 0)
  contents.each do |row|
    date = DateTime.strptime(row[:regdate], "%m/%d/%y %H:%M")
    day_count[date.strftime("%H").to_i] += 1
  end
  max = 0
  max_index = 0
  day_count.each_with_index do |value, index|
    if value > max
      max = value
      max_index = index
    end
  end
  max_index
end

def get_popular_day(contents)
  day_count = Array.new(6, 0)
  contents.each do |row|
    date = DateTime.strptime(row[:regdate], "%m/%d/%y %H:%M")
    day_count[date.wday] += 1
  end
  max = 0
  max_index = 0
  day_count.each_with_index do |value, index|
    if value > max
      max = value
      max_index = index
    end
  end
  case max_index
  when 0
    "Sunday"
  when 1
    "Monday"
  when 2
    "Tuesday"
  when 3
    "Wednesday"
  when 4
    "Thursday"
  when 5
    "Friday"
  when 6
    "Saturday"
  end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"
  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: "country",
      roles: ["legislatorUpperBody", "legistorLowerBody"],
    ).officials

    legislator_names = legislators.map do |legislator|
      legislator.name
    end
    legislators_string = legislator_names.join(", ")
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir("output") unless Dir.exist?("output")
  filename = "output/thaks_#{id}.html"

  File.open(filename, "w") do |file|
    file.puts form_letter
  end
end

puts "Event Manager Initialized!"

contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)

p get_popular_hour(contents)

contents.each do |row|
  name = row[:first_name]
  clean_phone(row[:homephone])
  zipcode = clean_zipcode(row[:zipcode])

  # template_letter = File.read("form_letter.erb")

  # erb_template = ERB.new template_letter
  # form_letter = erb_template.result(binding)
end
p get_popular_day(contents)
