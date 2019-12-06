
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
@savefile = ""
@loadfile = ""

# gets new record, asks if want to add another student ONCE DONE, repeats if yes 
def ask_add_student
  while true do 
    add_student_record
    puts "Type Y to create another new student record: "
    puts "Otherwise press Enter on empty field to exit."
    choice = STDIN.gets.strip 
    if !choice.empty? 
    add_student_record
    else 
      break 
    end     
  end 
end 

# code to add new student, split from larger method for simplicity 
def add_student_record
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

  puts "Type Name: "
    name = STDIN.gets.capitalize.chomp 
      if name == "" 
        name = "BLANK"
      end 
    puts "Type their favourite hobby: "
    hobby = STDIN.gets.capitalize.chomp
    puts "enter cohort: "
    cohort = months[STDIN.gets.capitalize.chomp]
      while cohort == nil 
        puts "Incorrect spelling, please enter cohort: "
        cohort = months[STDIN.gets.downcase.chomp]
      end 

    add_hash(name, cohort, hobby)
    puts "Now we have #{@students.count} students"
end 

def add_hash(name, cohort, hobby)
  @students << {name: name, cohort: cohort.to_sym, hobby: hobby}
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
  cohort = STDIN.gets.chomp.downcase.to_sym

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

  puts "1. Input new student"
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

def ask_save_file
  puts "Please input name of file you wish to save: "
  @savefile = STDIN.gets.chomp 
  filename = @savefile
  if filename.nil? 
     exit 
  elsif File.exists?(filename)
    save_students(filename)
    puts "Saved #{@students.count} to #{filename}"
  else 
    save_students
    puts "Sorry that file doesn't exist. Saved #{@students.count} to students.csv instead"
    exit 
  end 
  
end 

def ask_load_file
  puts "Please input name of file you wish to load: "
  @loadfile = STDIN.gets.chomp 
  filename = @loadfile
  if File.exists?(filename)
    load_students(filename)
    puts "loaded #{@students.count} from #{filename}"
  else 
    load_students
    puts "Sorry that file doesn't exist. Loaded #{@students.count} from students.csv instead" 
  end 
end 

def save_students(filename="students.csv")
  file = File.open(filename, "w") do |file| #this BLOCK does what it needs to do in the |file| then closes the file without explicitly saying closefile 
  @students.each do |student| 
    student_data = [student[:name], student[:cohort], student[:hobby]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end 
end 
end 

def load_students(filename="students.csv")
  file = File.open(filename, "r") do |file|
  file.readlines.each do |line| 
    name, cohort, hobby = line.chomp.split(',')
    
    add_hash(name, cohort, hobby)
  end 
end 
end 

def try_load_students
  filename = ARGV.first
  if filename.nil? 
    load_students
    puts "Loaded #{@students.count} from students.csv" 
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else 
    puts "Sorry #{filename} doesn't exist."
    exit 
  end 
end 

def process(selection)
  case selection
  when "1"
    ask_add_student
  when "2"
    show_students
  when "3"
    ask_save_file
    puts "Students saved."
  when "4"
    @students = []
    ask_load_file
    puts "Students loaded."
  when "9"
    puts "Goodbye :)"
    exit
  else 
    puts "I don't know what you mean, please try again: "
  end 
end 

def interactive_menu
  loop do 
    print_menu
    process(STDIN.gets.chomp)
  end 
end 

# nothing happens until we call the methods
# students = input_students
# print_header
try_load_students
interactive_menu
# print(students)
# print_by_cohort(students)
# print_footer(students)