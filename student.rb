require './person'

class Student < Person
  attr_reader :classroom
  attr_accessor :id, :parent_permission

  def initialize(name, age, parent_permission)
    super(name, age, parent_permission: parent_permission)
    @classroom = classroom
    @id = Random.rand(1..1000)
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def to_s
    "[Student] Name: #{@name}, ID: #{@id}, Age: #{@age}"
  end
end
