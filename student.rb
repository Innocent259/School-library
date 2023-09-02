require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(_id, age, name, classroom, parent_permission: true)
    @classroom = classroom
    super(age, name, classroom, parent_permission: parent_permission)
  end

  def classroom=(_classroom)
    @classroom.students.push(self) unless @classroom.students.member?(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
