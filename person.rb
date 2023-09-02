require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age, :rentals

  def initialize(age, name, specialization, parent_permission: true)
    super()
    @age = age
    @name = name
    @specialization = specialization
    @parent_permission = parent_permission
    @rentals = []
  end

  def add_rental(date, book)
    rental = Rental.new(date, self, book)
    @rentals << rental
    rental
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end

  def can_use_service?
    of_age? || @parent_permission
  end
end
