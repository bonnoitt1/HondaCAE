class MatMembership < ActiveRecord::Base
  validates :mat_name, :group_name, :presence => true
  belongs_to :material
  validates_associated :material
  belongs_to :group
  validates_associated :group
  validates_uniqueness_of :mat_name, scope: [:group_name]
 
  attr_accessible :mat_name, :group_name, :requested_by, :is_confirmed, :comments
    
end


