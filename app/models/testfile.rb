class Testfile < ActiveRecord::Base
	belongs_to :material
	belongs_to :group
	mount_uploader :filename, TestFileUploader
attr_accessible  :filename, :uploaded_by, :material_id, :mat_name, :mat_type, :group_id, :groupname, :group_owner_id, :comments, :confidence_level
end
