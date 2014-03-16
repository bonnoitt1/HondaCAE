class Testfile < ActiveRecord::Base
	belongs_to :material
	mount_uploader :filename, TestFileUploader
end
