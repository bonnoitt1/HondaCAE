class User < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :weights, dependent: :destroy
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGREX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with:        VALID_EMAIL_REGREX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  mount_uploader :avatar, AvatarUploader

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def log
      Activity.where("user_id = ?", id)
  end

  def log_goal
      Goal.where("user_id = ?", id)
  end
 
  def log_weight
      Weight.where("user_id = ?", id)
  end
  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
