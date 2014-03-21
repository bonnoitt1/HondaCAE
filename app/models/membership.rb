class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  attr_accessible :user_id, :group_id, :owner, :is_confirmed
end
