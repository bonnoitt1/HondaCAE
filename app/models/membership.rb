class Membership < ActiveRecord::Base
  belongs_to :group
  validates :group, presence: true
  belongs_to :user
  validates :user, presence: true
  attr_accessible :user_id, :group_id, :owner, :is_confirmed, :comments
end
