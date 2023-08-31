require_relative 'base_decorator'

class Trim_decorator < Base_decorator
  def correct_name
    given_name = @nameable.correct_name
    given_name.length > 10 ? given_name[0..9] : given_name
  end
end
