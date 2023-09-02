require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def list_all_books
    puts 'List of all books:'
    @books.each do |book|
      puts "#{book.title} by #{book.author}"
    end
  end

  def list_all_people
    puts 'List of all people:'
    @people.each do |person|
      puts "#{person.name} (ID: #{person.id})"
    end
  end

  def create_person_menu
    loop do
      puts "\nCreate a Person:"
      puts '1. Create a Teacher'
      puts '2. Create a Student'
      puts '3. Back to Main Menu'

      choice = gets.chomp.to_i

      case choice
      when 1
        create_teacher
      when 2
        create_student
      when 3
        break
      else
        puts 'Invalid choice. Please select a valid option.'
      end
    end
  end

  def create_teacher
    puts "Enter teacher's name:"
    name = gets.chomp
    puts "Enter teacher's age:"
    age = gets.chomp.to_i
    puts "Enter teacher's specialization:"
    specialization = gets.chomp
    create_person(name, age, 'teacher', specialization: specialization)
  end

  def create_student
    puts "Enter student's name:"
    name = gets.chomp
    puts "Enter student's age:"
    age = gets.chomp.to_i
    puts "Enter student's classroom:"
    classroom = gets.chomp
    create_person(name, age, 'student', classroom: classroom)
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    puts "#{book.title} by #{book.author} has been created."
  end

  def create_rental(date, person_id, book_title)
    person = @people.find { |p| p.id == person_id }
    book = @books.find { |b| b.title == book_title }

    if person.nil?
      puts "Person with ID #{person_id} not found."
    elsif book.nil?
      puts "Book with title '#{book_title}' not found."
    else
      rental = Rental.new(date, book, person)
      @rentals << rental
      puts "#{person.name} has rented '#{book.title}' by #{book.author} on #{date}."
    end
  end

  def list_rentals_for_person(person_id)
    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts "Person with ID #{person_id} not found."
    else
      puts "Rentals for #{person.name} (ID: #{person.id}):"
      rentals = @rentals.select { |r| r.person == person }
      rentals.each do |rental|
        puts "#{rental.book.title} by #{rental.book.author} on #{rental.date}"
      end
    end
  end

  def run
    puts 'Welcome to the Library Management App!'
    loop do
      puts "\nPlease choose an option:"
      puts '1. List all books'
      puts '2. List all people'
      puts '3. Create a teacher'
      puts '4. Create a student'
      puts '5. Create a book'
      puts '6. Create a rental'
      puts '7. List rentals for a person'
      puts '8. Quit'

      choice = gets.chomp.to_i

      case choice
      when 1
        list_all_books
      when 2
        list_all_people
      when 3
        puts "Enter teacher's name:"
        name = gets.chomp
        puts "Enter teacher's age:"
        age = gets.chomp.to_i
        puts "Enter teacher's specialization:"
        specialization = gets.chomp
        create_person(name, age, 'teacher', specialization: specialization)
      when 4
        puts "Enter student's name:"
        name = gets.chomp
        puts "Enter student's age:"
        age = gets.chomp.to_i
        puts "Enter student's classroom:"
        classroom = gets.chomp
        create_person(name, age, 'student', classroom: classroom)
      when 5
        puts 'Enter book title:'
        title = gets.chomp
        puts 'Enter book author:'
        author = gets.chomp
        create_book(title, author)
      when 6
        puts 'Enter rental date (YYYY-MM-DD):'
        date = gets.chomp
        puts 'Enter person ID:'
        person_id = gets.chomp.to_i
        puts 'Enter book title:'
        book_title = gets.chomp
        create_rental(date, person_id, book_title)
      when 7
        puts 'Enter person ID:'
        person_id = gets.chomp.to_i
        list_rentals_for_person(person_id)
      when 8
        puts 'Goodbye!'
        break
      else
        puts 'Invalid choice. Please select a valid option.'
      end
    end
  end
end
