
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

@students = []

def input_students
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
    choice = gets.strip 
    if !choice.empty? 
    # get a name from user
    puts "Type Name: "
    name = gets.capitalize.chomp 
      if name == "" 
        name = "BLANK"
      end 
    puts "Type their favourite hobby: "
    hobby = gets.capitalize.chomp
    puts "enter cohort: "
    cohort = months[gets.capitalize.chomp]
      while cohort == nil 
        puts "Incorrect spelling, please enter cohort: "
        cohort = months[gets.chomp.capitalize]
      end 

    @students << {name: name, cohort: cohort, hobby: hobby}

    puts "Now we have #{@students.count} students"
    else 
      break 
    end     
  end 
end 

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100) 
end 

def print_footer
  if @students.length > 1 
    puts "Overall, we have #{@students.count} great students".center(100)
  elsif @students.length < 1
    nil 
  else 
    puts "Overall, we have #{@students.count} great student".center(100)
  end 
end 

# Added until loop as per 8.4, kept each_with_index as wanted to keep numbered list...until is unnecessary REMOVE
def print_students_list
  counter = 0 
  until counter == @students.length 
    @students.each_with_index do |student, index|
    puts "#{index+1} #{student[:name]} (#{student[:cohort].capitalize} cohort), Hobby: #{student[:hobby]}".center(100)
    counter += 1
  end 
  end 
end 

def print_by_cohort
  puts "Input a cohort to print: "
  cohort = gets.chomp.downcase.to_sym

  @students.each do |student|
    if student[:cohort] == cohort 
      puts "#{student[:name]} (#{student[:cohort].capitalize} cohort),   Hobby: #{student[:hobby]}".center(100)
    end
  end 
end 
 
# Method to return names beginning with certain letter
def print_if_first_letter(letter)
  @students.each do |student, index|
  if student[:name][0] == letter
    puts "Students with names beginning with #{letter}: #{student[:name]} (#{student[:cohort]} cohort)"
  end 
  end 
end 

# Method to return students w/ names under 12 chars
def print_if_under_twelve
  @students.each do |student|
  if student[:name].length <= 12
    puts "Students with names shorter than 12 characters: #{student[:name]} (#{student[:cohort]} cohort)" 
  end 
  end 
end 

# Interactive menu methods--------------
def print_menu
  puts "Please select: "

  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"

  puts "9. Exit"
end 

def show_students
  print_header
  print_students_list
  print_footer
end 

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student| 
    student_data = [student[:name], student[:cohort], student[:hobby]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end 
  file.close
end 

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line| 
    name, cohort, hobby = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym, hobby: hobby}
  end 
  file.close
end 

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else 
    puts "I don't know what you meant, try again: "
  end 
end 

def interactive_menu
  loop do 
    print_menu
    process(gets.chomp)
  end 
end 

# nothing happens until we call the methods
# students = input_students
# print_header
interactive_menu
# print(students)
# print_by_cohort(students)
# print_footer(students)