class Share
  include ActiveModel::Model
  attr_accessor :share, :pass
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :share, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
end