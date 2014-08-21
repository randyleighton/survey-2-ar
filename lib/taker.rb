class Taker < ActiveRecord::Base
  belongs_to :survey
  has_many :responses
  before_save :downcase_user

  validates :user, :presence => true, :length => { :maximum => 12 }

private

  def downcase_user
    self.user = self.user.capitalize
  end

end
