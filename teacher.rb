require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(age, name, specialization)
    super(age, name, parent_permission: true)
    @id = Random.rand(1..1000)
    @specialization = specialization
  end

  def to_s
    "[Teacher] Name: #{@name}, ID: #{@id}, Age: #{@age}"
  end
end
