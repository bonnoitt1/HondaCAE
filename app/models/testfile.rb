class Testfile < ActiveRecord::Base
	belongs_to :material
	#validates :material, presence: true
	belongs_to :group
	#validates :group, presence: true
	
	mount_uploader :filename, TestFileUploader
attr_accessible  :filename, :uploaded_by, :person_in_charge, :test_location, :test_date, :file_type, :mat_name, :groupname, :comments, :confidence_level
end
