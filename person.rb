class Person
  def initialize(id, age, name: 'unknown', parent_permission: true)
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  attr_reader :id
  attr_accessor :name, :age

  private

  def of_age?
    @age >= 18
  end

  def can_use_service?
    of_age? || @parent_permission
  end
end
