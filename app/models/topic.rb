class Topic < ApplicationRecord
    validates :user_id, presence:true
    validates :description, presence:true
    
    belongs_to :user
    
    # carrierwave
    mount_uploader :image_path, ImageUploader

end
