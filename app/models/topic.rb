class Topic < ApplicationRecord
    validates :user_id, presence:true
    validates :description, presence:true
    
    belongs_to :user
    
    # carrierwave
    mount_uploader :image_path, ImageUploader
    
    has_many :likes
    has_many :like_users, through: :likes, source: 'user'
    
    has_secure_password


end
