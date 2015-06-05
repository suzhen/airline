class Question < ActiveRecord::Base
    
  validates :stem, presence: true
  validates :encrypt_stem, presence: true

  has_many :answers, inverse_of: :question, autosave: true,dependent: :destroy
end