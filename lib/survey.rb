class Survey < ActiveRecord::Base
  has_many :takers
  has_many :questions
  has_many :responses, through: :questions
end
