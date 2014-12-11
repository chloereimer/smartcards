class Card < ActiveRecord::Base

  # virtual attributes

  attr_accessor :is_tested, :is_correct

  # relatonships

  belongs_to :deck

  # validation
  
  validates :deck, presence: true
  validates :front, presence: true
  validates :back, presence: true

end
