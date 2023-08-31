require_relative 'base_decorator'

class Capitalize_decorator < Base_decorator
  def correct_name
    given_name = @nameable.correct_name
    given_name.upcase
  end
end
