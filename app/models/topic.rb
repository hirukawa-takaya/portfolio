class Topic < ApplicationRecord
  validates :description, presence: true, length:{ maximum: 255 }

  belongs_to :user
  has_many   :likes, dependent: :destroy
  has_many   :like_users, through: :likes, source: 'user'
  has_many   :comments, dependent: :destroy

  has_secure_password(validations: false)
  
  has_one_attached :image

end
