class Topic < ApplicationRecord
  validates :description, presence:true

  belongs_to :user
  has_many   :likes, dependent: :destroy
  has_many   :like_users, through: :likes, source: 'user'
  has_many   :comments, dependent: :destroy

  # presence:trueを無効
  has_secure_password(validations: false)
  
  has_one_attached :image

end
