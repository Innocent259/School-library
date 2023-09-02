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
    @books.each { |book| puts "#{book.title} by #{book.author}" }
  end

  def list_all_people
    puts 'List of all people:'
    @people.each { |person| puts person.name }
  end

  def create_person(age, name, role, options = {})
    case role
    when 'teacher'
      specialization = options[:specialization]
      person = Teacher.new(@people.length + 1, age, name, specialization)
    when 'student'
      classroom = options[:classroom]
      person = Student.new(@people.length + 1, age, name, classroom)
    else
      puts 'Invalid role. Person not created.'
      return
    end

    @people << person
    puts "#{person.name} has been created as a #{role}."
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    puts "#{book.title} by #{book.author} has been created."
  end

  def create_rental(date, person_id, book_title)
    person = find_person_by_id(person_id)
    book = find_book_by_title(book_title)

    return unless person && book

    rental = Rental.new(date, book, person)
    @rentals << rental
    puts "#{person.name} has rented '#{book.title}' by #{book.author} on #{date}."
  end

  def list_rentals_for_person(person_id)
    person = find_person_by_id(person_id)

    return unless person

    puts "Rentals for #{person.name} (ID: #{person.id}):"
    rentals = @rentals.select { |r| r.person == person }
    rentals.each { |rental| puts "#{rental.book.title} by #{rental.book.author} on #{rental.date}" }
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def run
    puts 'Welcome to the Library Management App!'
    loop do
      display_menu
      choice = gets.chomp.to_i

      case choice
      when 1 then list_all_books
      when 2 then list_all_people
      when 3 then create_teacher
      when 4 then create_student
      when 5 then create_book_prompt
      when 6 then create_rental_prompt
      when 7 then list_rentals_prompt
      when 8
        puts 'Goodbye!'
        break
      else
        handle_invalid_choice
      end
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  private

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

  def find_person_by_id(_person_id)
    @people.find { |person| person.classroom == classroom }
  end

  def find_book_by_title(book_title)
    @books.find { |book| book.title == book_title }
  end

  def handle_invalid_choice
    puts 'Invalid choice. Please select a valid option.'
  end

  def create_teacher
    puts "Enter teacher's age:"
    age = gets.chomp.to_i
    puts "Enter teacher's name:"
    name = gets.chomp
    puts "Enter teacher's specialization:"
    specialization = gets.chomp
    create_person(age, name, 'teacher', specialization: specialization)
  end

  def create_student
    puts "Enter student's name:"
    name = gets.chomp
    puts "Enter student's age:"
    age = gets.chomp.to_i
    puts "Enter student's classroom:"
    classroom = gets.chomp
    create_person(age, name, 'student', classroom: classroom)
  end

  def create_book_prompt
    puts 'Enter book title:'
    title = gets.chomp
    puts 'Enter book author:'
    author = gets.chomp
    create_book(title, author)
  end

  def create_rental_prompt
    puts 'Enter rental date (YYYY-MM-DD):'
    date = gets.chomp
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    puts 'Enter book title:'
    book_title = gets.chomp
    create_rental(date, person_id, book_title)
  end

  def list_rentals_prompt
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    list_rentals_for_person(person_id)
  end
end
