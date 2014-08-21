require 'active_record'
require './lib/survey'
require './lib/question'
require './lib/response'
require './lib/taker'
require './lib/choice'
require 'pry'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu

  system("clear")
  puts "***Surveys!!***\n\n"

  loop do
    puts "[1] - Create a new Survey"
    puts "[2] - View all Surveys"
    puts "[3] - Remove Surveys"
    puts "[4] - Add questions to a Survey"
    puts "[5] - View all Questions"
    puts "[6] - Add answers to a question"
    puts "[7] - Take a survey"
    puts "Press 'x' to exit"
    menu_choice = gets.chomp
    if menu_choice == '1'
      create_survey
    elsif menu_choice == '2'
      view_surveys
    elsif menu_choice == '3'
      remove_surveys
    elsif menu_choice == '4'
      add_question
    elsif menu_choice == '5'
      view_questions
    elsif menu_choice == '6'
      add_answers
    elsif menu_choice == '7'
      take_survey
    elsif menu_choice == 'x'
      puts "Goodbye!"
      exit
    else
      puts "Please input a valid choice"
    end
  end
end

def create_survey
  puts "\nPlease enter the name of the new survey:\n"
  user_input = gets.chomp
  new_survey = Survey.create({name: user_input})
  puts "#{new_survey.name} has been created.\n"
end

def view_surveys
  puts "Surveys: "
  puts "[id] -- Name"
  puts "--------------"
  Survey.all.each {|survey| puts "[#{survey.id}] -- #{survey.name}" }
  puts "\n\n"
end

def remove_surveys

end


main_menu
