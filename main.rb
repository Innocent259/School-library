require_relative 'app'

# rubocop:disable Metrics/CyclomaticComplexity
def main
  app = App.new
  puts 'Welcome to the Library Management App!'

  loop do
    display_menu
    choice = gets.chomp.to_i

    case choice
    when 1 then app.list_all_books
    when 2 then app.list_all_people
    when 3 then create_teacher(app)
    when 4 then create_student(app)
    when 5 then create_book_prompt(app)
    when 6 then create_rental_prompt(app)
    when 7 then list_rentals_prompt(app)
    when 8
      puts 'Goodbye!'
      break
    else
      handle_invalid_choice
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity

def display_menu
  puts "\nPlease choose an option:"
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a teacher'
  puts '4. Create a student'
  puts '5. Create a book'
  puts '6. Create a rental'
  puts '7. List rentals for a person'
  puts '8. Quit'
end

def create_teacher(app)
  puts "Enter teacher's age:"
  age = gets.chomp.to_i
  puts "Enter teacher's name:"
  name = gets.chomp
  puts "Enter teacher's specialization:"
  specialization = gets.chomp
  app.create_person(age, name, 'teacher', specialization: specialization)
end

def create_student(app)
  puts "Enter student's name:"
  name = gets.chomp
  puts "Enter student's age:"
  age = gets.chomp.to_i
  puts "Enter student's classroom:"
  classroom = gets.chomp
  app.create_person(age, name, 'student', classroom: classroom)
end

def create_book_prompt(app)
  puts 'Enter book title:'
  title = gets.chomp
  puts 'Enter book author:'
  author = gets.chomp
  app.create_book(title, author)
end

def create_rental_prompt(app)
  puts 'Enter rental date (YYYY-MM-DD):'
  date = gets.chomp
  puts 'Enter person ID:'
  person_id = gets.chomp.to_i
  puts 'Enter book title:'
  book_title = gets.chomp
  app.create_rental(date, person_id, book_title)
end

def list_rentals_prompt(app)
  puts 'Enter person ID:'
  person_id = gets.chomp.to_i
  app.list_rentals_for_person(person_id)
end

def handle_invalid_choice
  puts 'Invalid choice. Please select a valid option.'
end
main
