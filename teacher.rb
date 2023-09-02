require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(_id, age, name, specialization, parent_permission: true)
    super(age, name, specialization, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_service?
    true
  end
end
