require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(age, name, parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end

  public

  def can_use_services?
    @age >= 18 || @parent_permission
  end

  def add_rental(book, date)
    rentals << Rental.new(book, self, date)
  end

  def to_s
    "[Person] Name: #{name}, ID: #{id}, Age: #{age}"
  end
end
