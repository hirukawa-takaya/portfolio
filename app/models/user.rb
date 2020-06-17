class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence:true, length:{maximum:30}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }#大文字と小文字区別しない
    validates :password, presence:true, length:{minimum:6}
    has_secure_password
    
    has_many :topics
    has_many :likes
    has_many :like_topics, through: :likes, source: 'topic'

end
