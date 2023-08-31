require_relative 'nameable'

class Person < Nameable
  def initialize(age, name: 'unknown', parent_permission: true)
    super()
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  attr_accessor :name, :age

  private

  def of_age?
    @age >= 18
  end

  def can_use_service?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end
end
