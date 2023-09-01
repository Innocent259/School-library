require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(id, age, classroom, name: 'unknown', parent_permission: true)
    @classroom = classroom
    super(id, age, name: name, parent_permission: parent_permission)
  end

  def classroom=(classroom)
    @classroom = classroom
    @classroom.students.push(self) unless @classroom.students.member?(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
