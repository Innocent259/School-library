require_relative 'person'

class Student < Person
  attr_reader :classroom
  attr_accessor :id, :parent_permission

  def initialize(age, name, parent_permission)
    super(age, name)
    @id = Random.rand(1..1000)
    @parent_permission = parent_permission
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def to_s
    "[Student] Name: #{@name}, ID: #{@id}, Age: #{@age}"
  end
end
