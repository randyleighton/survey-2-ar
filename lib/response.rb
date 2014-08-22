class Response < ActiveRecord::Base

  belongs_to :choice
  belongs_to :question
  belongs_to :taker

  validates :choice_id, presence: true, numericality: { only_integer: true }

end
