require_relative 'app'

def display_welcome_message
  puts 'Welcome to School Library App!'
  puts
end

def user_input
  gets.chomp.to_i
end

def process_user_choice(app, choice)
  actions = {
    1 => :list_of_books,
    2 => :list_of_people,
    3 => :create_person_with_input,
    4 => :create_book_with_input,
    5 => :create_rental_with_input,
    6 => :search_rented_book_with_id,
    7 => :exit_app
  }

  action = actions[choice]
  if action
    app.send(action)
  else
    puts 'Invalid input, please try again.'
  end
end

def exit_app
  puts 'Exiting the app....'
  exit(0)
end

def main
  app = App.new
  loop do
    display_welcome_message
    app.display_menu
    choice = user_input
    process_user_choice(app, choice)
    puts
  end
end

main
