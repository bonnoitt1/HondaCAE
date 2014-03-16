class User < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :weights, dependent: :destroy
  has_many :memberships
  has_many :groups, through: :memberships
  attr_accessible :groupname, :description, :owner_id

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

  def log_membership
      Membership.where("user_id = ?", id)
  end
  
  def log_group
      Group.where("owner_id = ?", id)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
