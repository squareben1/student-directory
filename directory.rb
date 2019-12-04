
#put all students into array 
# students = [ 
#   {name: "Dr. Hannibal Lecter", cohort: :november, hobby: "Eating people"},
#   {name: "Darth Vader", cohort: :november, hobby: "evil"},
#   {name: "Nurse Ratched", cohort: :november, hobby: "evil"},
#   {name: "Michael Corleone", cohort: :november, hobby: "evil"},
#   {name: "Alex DeLarge", cohort: :november, hobby: "evil"},
#   {name: "The Wicked Witch of the West", cohort: :november, hobby: "evil"},
#   {name: "Terminator", cohort: :november, hobby: "evil"},
#   {name: "Freddy Krueger", cohort: :november, hobby: "evil"},
#   {name: "The Joker", cohort: :november, hobby: "evil"},
#   {name: "Joffrey Baratheon", cohort: :november, hobby: "evil"},
#   {name: "Norman Bates", cohort: :november, hobby: "evil"}
# ]

def input_students
  students = []
  months = {
    "January" => :january, 
    "February" => :february,
    "March" => :march, 
    "April" => :april, 
    "May" => :may, 
    "June" => :june, 
    "July" => :july, 
    "August" => :august, 
    "September" => :september, 
    "October" => :october, 
    "November" => :november, 
    "December" => :december, 
    "" => :no
  }
  # ask if user wants to add student record 
  # while the choice is Y (or not blank), repeat this code 
  while true do 
    puts "Type Y to create new student record: "
    puts "Press Enter on empty field to exit."
    choice = gets.chomp 
    if !choice.empty? 
    # get a name from user
    puts "Type Name: "
    name = gets.chomp 
      if name == "" 
        name = "BLANK"
      end 
    puts "Type their favourite hobby: "
    hobby = gets.chomp
    puts "enter cohort: "
    cohort = months[gets.chomp.capitalize]
    while cohort == nil 
        puts "Incorrect spelling, please enter cohort: "
        cohort = months[gets.chomp.capitalize]
      end 

    students << {name: name, cohort: cohort, hobby: hobby}

    puts "Now we have #{students.count} students"
  else 
    break 
  end 
    
  end 
    # return array of students
    students 
end 

def print_header
puts "The students of Villains Academy".center(100)
puts "-------------".center(100)
end 

# Added until loop as per 8.4, kept each_with_index as wanted to keep numbered list...until is unnecessary REMOVE
def print(students)
  counter = 0 
  until counter == students.length 
    students.each_with_index do |student, index|
    puts "#{index+1} #{student[:name]} (#{student[:cohort].capitalize} cohort), Hobby: #{student[:hobby]}".center(100)
    counter += 1
  end 
  end 
end 

def print_by_cohort(students)
  puts "Input a cohort to print: "
  cohort = gets.chomp.to_sym

  students.each do |student|
    if student[:cohort] == cohort 
      puts "#{student[:name]} (#{student[:cohort].capitalize} cohort),   Hobby: #{student[:hobby]}".center(100)
    end
  end 
end 
 

# Method to return names beginning with certain letter
def print_if_first_letter(students, letter)
  students.each do |student, index|
  if student[:name][0] == letter
    puts "Students with names beginning with #{letter}: #{student[:name]} (#{student[:cohort]} cohort)"
  end 
  end 
end 

# Method to return students w/ names under 12 chars
def print_if_under_twelve(students)
  students.each do |student|
  if student[:name].length <= 12
    puts "Students with names shorter than 12 characters: #{student[:name]} (#{student[:cohort]} cohort)" 
  end 
  end 
end 

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(100)
end 

# nothing happens until we call the methods
students = input_students
print_header
# print(students)
print_by_cohort(students)
print_footer(students)