class MatMembership < ActiveRecord::Base
  belongs_to :material
  validates :material, presence: true  
  belongs_to :group
  validates :group, presence: true
  validates_uniqueness_of :material_id, scope: [:group_id]
  attr_accessible :material_id, :group_id, :requested_by, :is_confirmed, :comments

end
