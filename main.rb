require_relative 'app'

def main
  app = App.new
  puts 'Welcome to the Library Management App!'

  loop do
    display_menu
    choice = gets.chomp.to_i

    case choice
    when 1 then app.list_all_books
    when 2 then app.list_all_people
    when 3 then create_person_menu(app)
    when 4 then create_book_prompt(app)
    when 5 then create_rental_prompt(app)
    when 6 then list_rentals_prompt(app)
    when 7
      puts 'Goodbye!'
      break
    else
      handle_invalid_choice
    end
  end
end

def display_menu
  puts "\nPlease choose an option:"
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person (teacher/student)'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List rentals for a person'
  puts '7. Quit'
end

def create_person_menu(app)
  loop do
    puts "\nCreating a person:"
    puts 'Choose the role:'
    puts '1. Teacher'
    puts '2. Student'
    puts '3. Go back to the main menu'

    choice = gets.chomp.to_i

    case choice
    when 1 then create_person(app, 'teacher')
    when 2 then create_person(app, 'student')
    when 3
      puts 'Going back to the main menu.'
      break
    else
      puts 'Invalid choice. Please select a valid option.'
    end
  end
end

def create_person(app, role)
  puts "Enter #{role}'s age:"
  age = gets.chomp.to_i
  puts "Enter #{role}'s name:"
  name = gets.chomp

  if role == 'teacher'
    puts "Enter #{role}'s specialization:"
    specialization = gets.chomp
    app.create_person(age, name, role, specialization: specialization)
  elsif role == 'student'
    puts "Enter #{role}'s classroom:"
    classroom = gets.chomp
    app.create_person(age, name, role, classroom: classroom)
  end

  puts "#{name} has been created as a #{role}."
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
