require 'spec_helper'

describe Question do
  it { should belong_to :survey }
  it { should have_many :choices }
  it { should have_many :responses }

  # it "should return the number of responses to each question choice"
  #   new_survey = Survey.create({name: 'Cheesy Survey'})
  #   new_question = Question.create({description: 'Like cheese?', survey_id:new_survey.id})
  #   new_taker = Taker.create(user: 'Chucky', survey_id: new_survey.id)
  #   choice1 = Choice.create({question_id: new_question.id, description: 'yes'})
  #   choice2 = Choice.create({question_id: new_question.id, description: 'no'})
  #   choice3 = Choice.create({question_id: new_question.id, description: 'yo'})
  #   new_response = Response.new({taker_id: 1, question_id: new_question.id, choice_id: choice1.id})
  #   new_response = Response.new({taker_id: 2, question_id: new_question.id, choice_id: choice2.id})

  #   expect(new_question.find_responses(choice1)).to eq [1,.50]

end
