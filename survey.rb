require 'active_record'
require './lib/survey'
require './lib/question'
require './lib/response'
require './lib/taker'
require './lib/choice'
require './lib/colors'
require 'pry'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu

  system("clear")
  puts "***Surveys!!***\n\n".blue

  loop do
    puts "[1] - Add Survey"
    puts "[2] - View Surveys"
    puts "[3] - Delete Survey"
    puts "\n[== Questions ==]\n".green
    puts "[4] - Add question"
    puts "[5] - View Questions"
    puts "[6] - Delete Question"
    puts "\n[== Choices/Answers ==]\n".green
    puts "[7] - Add choices to question"
    puts "[8] - View choices"
    puts "\n[== Survey ==]\n".green
    puts "[9] - Create a User ID"
    puts "[10] - Delete User Login"
    puts "[11] - Take a survey"
    puts "[12] - View Individual Survey Results"
    puts "[13] - View Total Results"
    puts "\n"
    puts "Press 'x' to exit".red
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
        delete_user_login
    elsif menu_choice == '11'
      take_survey
    elsif menu_choice == '12'
      view_results
    elsif menu_choice == '13'
      view_totals_averages
    elsif menu_choice == 'x'
      puts "Goodbye!".bg_red.cyan
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

def view_survey_list
  puts "Surveys: "
  puts "[id] -- Name"
  puts "--------------"
  Survey.all.each {|survey| puts "[#{survey.id}] -- #{survey.name}" }
  puts "\n\n"
end

def view_surveys
  puts "Surveys: "
  puts "[id] -- Name"
  puts "--------------"
  Survey.all.each {|survey| puts "[#{survey.id}] -- #{survey.name}" }
  puts "\n\n"
  print "\nSelect survey [#] to view full survey: "
  survey_input = gets.chomp.to_i
  current_survey = Survey.find(survey_input)
  system("clear")
  puts "Survey: #{current_survey.name}"
  puts "\n"
  puts "[id] -- question"
  puts "----------------"
  current_survey.questions.each do |question|
    puts "#{question.id} -- #{question.description}"
    question.choices.each do |choice|
      puts "#{choice.description}"
    end
    puts "\n"
  end
  puts "---------------------"
end

def remove_surveys
view_surveys
print "\n\nSurvey [#] to remove: "
user_input = gets.chomp.to_i
current_survey = Survey.find(user_input)
puts "#{current_survey.name} removed."
current_survey.delete
puts "\n\n"
end

def add_question
  view_survey_list
  print "\nSelect survey [#] to add a question: "
  survey_input = gets.chomp.to_i
  current_survey = Survey.find(survey_input)
  puts "\nWrite your survey question here: "
  user_question = gets.chomp
  new_question = Question.create({:description => user_question, :survey_id => survey_input})
  puts "\n'#{new_question.description}' has been added to survey: #{current_survey.name}."
  puts "\n"
  3.times do
    puts "Enter possible answer: "
    answer_input = gets.chomp
    choice_answer = Choice.create({description: answer_input, question_id: new_question.id})
  end
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
  puts "\nSelect question [#] to delete: "
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
  puts "\n"
  current_question = Question.find(question_input)
  3.times do
    puts "Enter possible answer: "
    answer_input = gets.chomp
    choice_answer = Choice.create({description: answer_input, question_id: current_question.id})
  end
  puts "\n"
end

def view_choices
  view_questions
  print "Enter [#] of question to view choices: "
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
  print "Please enter a User name: "
  user_name = gets.chomp
  puts "\n"
  current_name = Taker.new({:user => user_name})
  if current_name.save
    puts "#{current_name.user} has been saved."
  else
    puts "Error. Please try again."
  end
  puts "\n"
end

def view_user_logins
  puts "User Logins: "
  puts "[id] -- Username"
  puts "--------------"
  Taker.all.each {|taker| puts "#{taker.id} -- #{taker.user}"}
end

def delete_user_login
  view_user_logins
  print "Choose login [#] to delete: "
  delete_choice = gets.chomp.to_i
  current_taker = Taker.find(delete_choice)
  puts "#{current_taker.user} deleted."
  current_taker.delete
  puts "\n"
end

def take_survey
  view_user_logins
  print "choose User id [#] "
  taker_input = gets.chomp.to_i
  current_taker = Taker.find(taker_input)
  system("clear")
  puts "#{current_taker.user} logged in."
  view_survey_list
  print "\nSelect survey [#] to take survey: "
  survey_input = gets.chomp.to_i
  current_survey = Survey.find(survey_input)
  puts "Question:"
  puts "[id] -- question"
  puts "----------------"
  current_survey.questions.each do |question|
    puts "#{question.id} -- #{question.description}"
    question.choices.each do |choice|
      puts "[#{choice.id}] #{choice.description}"
    end
    print "\nEnter the [#] of your choice: "
    choice_answer = gets.chomp
    current_response = Response.new({choice_id: choice_answer, question_id: question.id, taker_id: current_taker.id})
    if current_response.save
      puts "Response #(#{current_response.id}) has been saved."
    else
      puts "Error. Please try again."
      redo
    end
  end
  puts "\n"
end

def view_results
  view_survey_list
  print "\nSelect survey [#] to view survey responses: "
  survey_input = gets.chomp.to_i
  system("clear")
  current_survey = Survey.find(survey_input)
    current_survey.responses.each do |response|
      current_responder = Taker.find(response.taker_id)
      current_question = Question.find(response.question_id)
      current_choice = Choice.find(response.choice_id)
      puts "Survey Taker: #{current_responder.user} -- Question: #{current_question.description}"
      puts "-- answer: #{current_choice.description}"
      puts "--------------------------------------------"
      puts "\n"
    end

end

def view_totals_averages
  view_survey_list
  print "\nSelect survey [#] to view survey responses: "
  survey_input = gets.chomp.to_i
  system("clear")
  current_survey = Survey.find(survey_input)
  puts "[========== Survey Responses =============]"
  current_survey.questions.each do |question|
    choices = question.choices
    total_choices = choices.length
    total_responses = question.responses.length
    puts question.description
    choices.each do |choice|
      puts choice.description
      total = choice.responses.length
      puts "total: #{total}  -  #{total.to_f / total_responses*100}%"
    end
  end
end

main_menu
