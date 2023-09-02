require './person'

class Teacher < Person
  attr_accessor :id, :specialization

  def initialize(name, age, specialization)
    super(name, age)
    @specialization = specialization
    @id = Random.rand(1..1000)
  end

  def can_use_services?
    true
  end

  def to_s
    "[Teacher] Name: #{@name}, ID: #{@id}, Age: #{@age}"
  end
end
