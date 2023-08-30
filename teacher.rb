require_relative 'person'  

class Teacher < Person
    attr_reader :specialization
    def initialize(id, age, specialization, name: "unknown", parent_permission: true)
        super(id, age, name: name, parent_permission: parent_permission)
        @specialization = specialization
    end
    
    def can_use_service?
        true  # Override to always return true
    end
end