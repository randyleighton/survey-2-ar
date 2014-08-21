require 'active_record'
require 'rspec'
require 'shoulda-matchers'

require 'choice'
require 'question'
require 'response'
require 'survey'
require 'taker'


ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'])

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each {|survey| survey.destroy}
    Question.all.each {|question| question.destroy}
    Choice.all.each {|choice| choice.destroy}
    Taker.all.each {|taker| taker.destroy}
    Response.all.each {|response| response.destroy}
  end
end
