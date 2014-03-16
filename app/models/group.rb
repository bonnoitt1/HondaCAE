class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  attr_accessible :groupname, :description, :is_public, :owner_id, :owner_email
end
