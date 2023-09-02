require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(id, age, name, classroom, parent_permission: true)
    @classroom = classroom
    super(age, name, classroom, parent_permission: parent_permission)
  end

  def classroom=(classroom)
    @classroom = classroom
    @classroom.students.push(self) unless @classroom.students.member?(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
