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

  private

  def find_person_by_id(person_id)
    @people.find { |person| person.id == person_id }
  end

  def find_book_by_title(book_title)
    @books.find { |book| book.title == book_title }
  end
end
