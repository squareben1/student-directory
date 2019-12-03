
# #put all students into array 
students = [ 
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #create empty array
  students = []
  # get the first name 
  name = gets.chomp 
  #while the name is not empty, repeat this code 
  while !name.empty? do 
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from user
    name = gets.chomp 
    end 
    # return array of students
    students 
  end 

def print_header
puts "The students of Villains Academy"
puts "-------------"
end 

# Added until loop as per 8.4, kept each_with_index as wanted to keep numbered list...until is unnecessary REMOVE
def print(students)
  counter = 0 
  until counter == students.length 
    students.each_with_index do |student, index|
    puts "#{index+1} #{student[:name]} (#{student[:cohort]} cohort)"
    counter += 1
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
  puts "Overall, we have #{students.count} great students"
end 

# nothing happens until we call the methods
# students = input_students
print_header
print(students)
print_footer(students)