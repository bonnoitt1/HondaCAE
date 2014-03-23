class Group < ActiveRecord::Base
  has_many :memberships, :foreign_key => "group_id", dependent: :destroy
  has_many :users, through: :memberships
  has_many :testfiles, :foreign_key => "group", dependent: :destroy
  attr_accessible :groupname, :description, :is_public, :owner_id, :owner_email, :owner_name
end
