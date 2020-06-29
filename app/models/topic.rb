class Topic < ApplicationRecord
  validates :user_id, presence:true
  validates :description, presence:true

  belongs_to :user
  has_many   :likes, dependent: :destroy
  has_many   :like_users, through: :likes, source: 'user'
  has_many   :comments, dependent: :destroy

  # carrierwave
  mount_uploader :image_path, ImageUploader

  # presence:trueを無効
  has_secure_password(validations: false)

end
