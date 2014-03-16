class Material < ActiveRecord::Base
	has_many :testfiles, :foreign_key => "mat_name", dependent: :destroy
end
