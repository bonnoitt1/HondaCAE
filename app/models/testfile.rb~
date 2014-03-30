class Testfile < ActiveRecord::Base
	belongs_to :material
	validates :material, presence: true
	belongs_to :group
	validates :group, presence: true
	mount_uploader :filename, TestFileUploader
attr_accessible  :filename, :uploaded_by, :material_id, :mat_name, :mat_type, :group_id, :groupname, :group_owner_id, :comments, :confidence_level
end
