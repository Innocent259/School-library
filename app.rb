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

  def book_list
    puts 'List of all books'
    @books.each do |book|
      puts "Title: \"#{book.title}\" , Author: #{book.author}"
    end
  end

  def people_list
    puts 'List of all people'
    @people.each do |person|
      puts person
    end
  end

  def create_student(age, name, parent_permission)
    student = Student.new(age, name, parent_permission)
    @people << student
  end

  def create_teacher(age, name, specialization)
    teacher = Teacher.new(age, name, specialization)
    @people << teacher
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
  end

  def create_rental(date, book, person)
    rental = Rental.new(date, book, person)
    @rentals << rental
  end

  def books_for_rent
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\" , Author: #{book.author}"
    end
  end

  def all_renters
    @people.each_with_index do |person, index|
      if person.is_a?(Student)
        puts "#{index}) [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      elsif person.is_a?(Teacher)
        puts "#{index}) [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      else
        puts "#{index}) [Unknown Person] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def rented_book(selection_id)
    return @books[selection_id].id unless selection_id.negative? || selection_id > @books.length

    puts 'Invalid Selection. Please choose a valid index'
  end

  def renter_person(selection_id)
    return @people[selection_id].id unless selection_id.negative? || selection_id > @people.length

    puts 'Invalid Selection. Please choose a valid index'
  end

  def view_book_by_renters(id)
    rented_books_by_id = @rentals.select { |rental| rental.person == id.to_i }

    if rented_books_by_id.empty?
      puts 'No rentals found for this id'
    else
      rented_books_by_id.each do |rental|
        book = @books.find { |item| item.id == rental.book }
        puts "Date: #{rental.date} ,Title: #{book.title} by #{book.author}"
      end
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    input_user = gets.chomp.to_i
    case input_user
    when 1
      create_student_with_one
    when 2
      create_teacher_with_three
    else
      puts 'Invalid input'
    end
  end

  def create_student_with_one
    puts 'Generating Student...'
    print 'Student Age:'
    age = gets.chomp.to_i
    print 'Student Name:'
    name = gets.chomp
    print 'Parent Permission (y/n): '
    parent_permission = gets.chomp.downcase
    parent_permission = parent_permission == 'y'
    create_student(age, name, parent_permission)
    puts 'Student created successfully'
  end

  def create_teacher_with_three
    puts 'Generating Teacher...'
    print 'Teacher Age:'
    age = gets.chomp.to_i
    print 'Teacher Name:'
    name = gets.chomp
    print 'Specialization:'
    specialization = gets.chomp.to_s
    create_teacher(age, name, specialization)
    puts 'Teacher created successfully'
  end

  def create_a_book
    puts 'Provide book information'
    print 'Book Title: '
    title = gets.chomp
    print 'Author Name: '
    author = gets.chomp
    create_book(title, author)
    puts 'Book created successfully'
  end

  def create_a_rental
    puts 'Provide rental information'
    puts 'Select book from the following list by number: '
    books_for_rent
    book_id = gets.chomp.to_i
    book = rented_book(book_id)

    puts 'Select person from the following list by number (not id): '
    all_renters
    person_id = gets.chomp.to_i
    person = renter_person(person_id)

    puts "Selected person: #{person.name} (ID: #{person.id}), Age: #{person.age}, Role: #{person.class}"

    print 'Date: '
    date = gets.chomp.to_s
    create_rental(date, book, person)
    puts 'Rental created successfully'
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

  def search_rental_by_id
    print 'ID of the person: '
    id = gets.chomp.to_i
    puts 'List all rentals'
    view_book_by_renters(id)
  end
end
