require_relative 'base_decorator'

class CapitalizeDecorator < BaseDecorator
  def correct_name
    given_name = @nameable.correct_name
    given_name.capitalize
  end
end
