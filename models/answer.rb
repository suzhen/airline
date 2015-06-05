class Answer < ActiveRecord::Base
    
  validates :item, presence: true
  validates :encrypt_item, presence: true

  belongs_to :question, inverse_of: :answers ,touch: true

end