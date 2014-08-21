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
    puts "[1] - Add Survey"
    puts "[2] - View Surveys"
    puts "[3] - Delete Survey"
    puts "\n[== Questions ==]\n"
    puts "[4] - Add question"
    puts "[5] - View Questions"
    puts "[6] - Delete Question"
    puts "\n[== Choices/Answers ==]\n"
    puts "[7] - Add choices to question"
    puts "[8] - View choices"
    puts "\n[== Survey ==]\n"
    puts "[9] - Create a User ID"
    puts "[10] - Take a survey"
    puts "\n"
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
      delete_question
    elsif menu_choice == '7'
      add_choice
    elsif menu_choice == '8'
      view_choices
    elsif menu_choice == '9'
        create_user
    elsif menu_choice == '10'
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
view_surveys
print "\n\nSurvey [#] to remove:"
user_input = gets.chomp.to_i
current_survey = Survey.find(user_input)
puts "#{current_survey.name} removed."
current_survey.delete
puts "\n\n"
end

def add_question
  view_surveys
  print "\nSelect survey [#] to add a question:"
  survey_input = gets.chomp.to_i
  current_survey = Survey.find(survey_input)
  puts "\nWrite your survey question here:"
  user_question = gets.chomp
  new_question = Question.create({:description => user_question, :survey_id => survey_input})
  puts "\n'#{new_question.description}' has been added to survey: #{current_survey.name}."
  puts "\n"
end

def view_questions
  puts "Questions: "
  puts "[id] -- Survey -- Description"
  puts "--------------------------------"
  Question.all.each {|question| puts "[#{question.id}] -- #{question.survey_id} -- #{question.description}" }
  puts "\n\n"
end

def delete_question
  view_questions
  puts "\nSelect question [#] to delete:"
  question_select = gets.chomp.to_i
  current_question = Question.find(question_select)
  current_question.delete
  puts "'#{current_question.description}' has been deleted."
  puts "\n"
end

def add_choice
  puts "Add choices to a question"
  puts "-------------------------"
  view_questions
  print "Enter [#] of question to add choices to: "
  question_input = gets.chomp.to_i
  current_question = Question.find(question_input)
  3.times do
    puts "Enter possible answer: "
    answer_input = gets.chomp
    answer = Choice.create({description: answer_input})
    current_question.choices << answer
  end

end

def view_choices
  view_questions
  print "Enter [#] of question to view choices"
  question_input = gets.chomp.to_i
  current_question = Question.find(question_input)
  system("clear")
  puts "'#{current_question.description}'\n"
  puts "[id] -- Description"
  puts "---------------------------------"
  current_question.choices.each  do |choice|
    puts "[#{choice.id}] -- #{choice.description}"
  end
  puts "\n\n"
end

def create_user
puts "Please enter a User name:"
end

def take_survey
puts ""
end


main_menu
