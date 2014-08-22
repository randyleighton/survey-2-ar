class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices
  has_many :responses

  def find_responses
  sum = 0
    self.responses.where()
  end
end
