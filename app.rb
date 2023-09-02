require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'
require_relative 'student'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def run
    loop do
      display_menu
      choice = gets.chomp.to_i

      case choice
      when 1 then list_all_books
      when 2 then list_all_people
      when 3 then create_person
      when 4 then create_book
      when 5 then create_rental
      when 6 then search_rented_books_by_person
      when 7
        exit_app
        break
      else
        puts 'Invalid input. Please choose a valid option.'
      end
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  private

  def list_all_books
    puts 'List of all books'
    @books.each_with_index do |book, index|
      puts "#{index + 1}) Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_all_people
    puts 'List of all people'
    @people.each_with_index do |person, index|
      puts "#{index + 1}) #{person_info(person)}"
    end
  end

  def person_info(person)
    name = person.name.capitalize
    if person.is_a?(Student)
      "[Student] Name: #{name}, ID: #{person.id}, Age: #{person.age}"
    elsif person.is_a?(Teacher)
      "[Teacher] Name: #{name}, ID: #{person.id}, Age: #{person.age}, Specialization: #{person.specialization}"
    else
      "[Unknown Person] Name: #{name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    input_user = gets.chomp.to_i

    case input_user
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid input'
    end
  end

  def create_student
    puts 'Generating Student...'
    print 'Student Age:'
    age = gets.chomp.to_i
    print 'Student Name:'
    name = gets.chomp.capitalize
    print 'Parent Permission (y/n): '
    parent_permission = gets.chomp.downcase == 'y'
    create_person_record(Student.new(age, name, parent_permission))
    puts 'Student created successfully'
  end

  def create_teacher
    puts 'Generating Teacher...'
    print 'Teacher Age:'
    age = gets.chomp.to_i
    print 'Teacher Name:'
    name = gets.chomp.capitalize
    print 'Specialization:'
    specialization = gets.chomp
    create_person_record(Teacher.new(age, name, specialization))
    puts 'Teacher created successfully'
  end

  def create_book
    puts 'Provide book information'
    print 'Book Title: '
    title = gets.chomp
    print 'Author Name: '
    author = gets.chomp
    create_book_record(Book.new(title, author))
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Provide rental information'
    puts 'Select book from the following list by number: '
    list_all_books
    book_id = gets.chomp.to_i - 1
    book = @books[book_id]
    puts 'Select person from the following list by number (not id): '
    list_all_people
    person_id = gets.chomp.to_i - 1
    person = @people[person_id]
    print 'Date: '
    date = gets.chomp.to_s
    create_rental_record(Rental.new(date, book, person))
    puts 'Rental created successfully'
  end

  def list_rentals_for_person
    print 'ID of the person: '
    id = gets.chomp.to_i
    display_rentals_for_person(id)
  end

  def display_rentals_for_person(id)
    rented_books_by_id = @rentals.select { |rental| rental.person.id == id }

    if rented_books_by_id.empty?
      puts 'No rentals found for this id'
    else
      puts 'List of rentals:'
      rented_books_by_id.each do |rental|
        puts "Date: #{rental.date}, Title: #{rental.book.title} by #{rental.book.author}"
      end
    end
  end

  def display_menu
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def create_person_record(person)
    @people << person
  end

  def create_book_record(book)
    @books << book
  end

  def create_rental_record(rental)
    @rentals << rental
  end
end

app = App.new
app.run
