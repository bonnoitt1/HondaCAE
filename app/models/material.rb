class Material < ActiveRecord::Base
	has_many :testfiles, :foreign_key => "mat_name", dependent: :destroy
attr_accessible :density, :elastic_modulus, :shear_modulus, :poissons_ratio, :yield_strength, :ultimate_tensile_strength, :ultimate_total_elongation, :hardness_value, :melting_point, :thermal_expansion, :thermal_conductivity, :specific_heat, :electrical_resistivity, :chemical_composition, :mat_name, :mat_type

end
