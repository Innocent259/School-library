require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :rentals

  def initialize(age, name: 'unknown', parent_permission: true)
    super()
    @age = age
    @name = name
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

  def can_use_service?
    of_age? || @parent_permission
  end

  def add_rental(rental)
    rentals << rental
  end
end
