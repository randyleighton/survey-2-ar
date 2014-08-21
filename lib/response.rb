class Response < ActiveRecord::Base

belongs_to :choice
belongs_to :question
has_many :takers

end
