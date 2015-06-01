class Trouble < ActiveRecord::Base
    
  validates :question, presence: true
  validates :encrypt_question, presence: true
  validates :answers, presence: true
  validates :correct, presence: true

end