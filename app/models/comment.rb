class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic, optional: true
  
  validates :content, presence: true, length: { maximum: 225 }
end
