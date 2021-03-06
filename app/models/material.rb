class Material < ActiveRecord::Base
	validates :mat_name, :presence => true

	validates :mat_type, :inclusion => { :in => ['Liquid', 'Metal', 'Misc', 'Mixture', 'Plastic', 'Rubber'],
    :message => "%{value} is not a valid type" }

	validates :density, :elastic_modulus, :shear_modulus, :poissons_ratio, :yield_strength,
	 :ultimate_tensile_strength, :ultimate_total_elongation, :hardness_value, :melting_point,
	 :thermal_expansion, :thermal_conductivity, :specific_heat, :electrical_resistivity,
	 :chemical_composition, :allow_nil => true,:numericality => true

	validates_uniqueness_of :mat_name, scope: [:mat_type]

	has_many :testfiles, :foreign_key => "mat_name", dependent: :destroy
	has_many :mat_membership, :foreign_key => "mat_name"
	has_many :groups, through: :mat_membership

	attr_accessible :density, :elastic_modulus, :shear_modulus, :poissons_ratio, :yield_strength,
	 :ultimate_tensile_strength, :ultimate_total_elongation, :hardness_value, :melting_point,
 	 :thermal_expansion, :thermal_conductivity, :specific_heat, :electrical_resistivity,
	 :chemical_composition, :mat_name, :mat_type, :confidence_level
	
	filterrific(
  	:default_settings => { :sorted_by => 'id_asc' },
  	:filter_names => [:search_query,:sorted_by,:direction_order,:with_created_at_gte,:with_mat_type,:col_name,:range_query]
	)

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |material|
			  csv << material.attributes.values_at(*column_names)
			end
		end
	end

  self.per_page = 100

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(materials.mat_name) LIKE ?",
          "LOWER(materials.mat_type) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }
  

  def self.options_for_order
	[
	   ['asc'],
	   ['desc']
	]
  end

  scope :col_name, lambda { |colname|
	@@column = colname.to_s
	case colname.to_s
	when /^desc$/
		Material.col_name(session[:filterrific_materials].col_name.to_s)
	else
		order("materials.#{ colname.to_s } asc")
	end
    }
 

  scope :direction_order, lambda { |direction|
	Material.col_name('desc')
  }

  
  
  scope :sorted_by, lambda { |sort_option| 
    # extract the sort direction from the param value.
    direction = (sort_option =~ /asc$/) ? 'asc' : 'desc'
    case sort_option.to_s
    when /^id_/
      order("materials.id #{ direction }")
    when /^created_at_/
      order("materials.created_at #{ direction }")
    when /^mat_name_/
      order("LOWER(materials.mat_name) #{ direction }")
    when /^density_/
      order("materials.density #{ direction }")
    when /^elastic_modulus_/
      order("materials.elastic_modulus #{ direction }")
    when /^shear_modulus_/
      order("materials.shear_modulus #{ direction }")
    when /^poissons_ratio_/
      order("materials.poissons_ratio #{ direction }")
    when /^yield_strength_/
      order("materials.yield_strength #{ direction }")
    when /^ultimate_tensile_strength_/
      order("materials.ultimate_tensile_strength #{ direction }")
    when /^ultimate_total_elongation_/
      order("materials.ultimate_total_elongation #{ direction }")
    when /^hardness_value_/
      order("materials.hardness_value #{ direction }")
    when /^melting_point_/
      order("materials.melting_point #{ direction }")
    when /^thermal_expansion_/
      order("materials.thermal_expansion #{ direction }")
    when /^thermal_conductivity_/
      order("materials.thermal_conductivity #{ direction }")
    when /^specific_heat_/
      order("materials.specific_heat #{ direction }")
    when /^electrical_resistivity_/
      order("materials.electrical_resistivity #{ direction }")
    when /^chemical_composition_/
      order("materials.chemical_composition #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  
  scope :with_created_at_gte, lambda { |ref_date|
    where('materials.created_at >= ?', ref_date)
  }
  
  scope :sorted_by_type, lambda { |sort_option_type|
    # extract the sort direction from the param value.
    direction = (sort_option_type =~ /desc$/) ? 'desc' : 'asc'
    case sort_option_type.to_s
    when /^type_/
      order("materials.type")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_mat_type, lambda { |mat_type|
    where(:mat_type => [*mat_type])
  }
  
  def self.options_for_sorted_by
    [
	['Name (a-z)', 'mat_name_asc'],
	['Registration date (newest first)', 'created_at_desc'],
	['Registration date (oldest first)', 'created_at_asc'],
	['Density (Smallest to Largest)', 'density_asc'],
	['Density (Largest to Smallest)', 'density_desc'],
	['Elastic Modulus (Smallest to Largest)', 'elastic_modulus_asc'],
	['Elastic Modulus (Largest to Smallest)', 'elastic_modulus_desc'],
	['Shear Modulus (Smallest to Largest)', 'shear_modulus_asc'],
	['Shear Modulus (Largest to Smallest)', 'shear_modulus_desc'],
	['Poissons Ratio (Smallest to Largest)', 'poissons_ratio_asc'],
	['Poissons Ratio (Largest to Smallest)', 'poissons_ratio_desc'],
	['Yield Strength (Smallest to Largest)', 'yield_strength_asc'],
	['Yield Strength (Largest to Smallest)', 'yield_strength_desc'],
	['Ultimate Tensile Strength (Smallest to Largest)', 'ultimate_tensile_strength_asc'],
	['Ultimate Tensile Strength (Largest to Smallest)', 'ultimate_tensile_strength_desc'],
	['Ultimate Total Elongation (Smallest to Largest)', 'ultimate_total_elongation_asc'],
	['Ultimate Total Elongation (Largest to Smallest)', 'ultimate_total_elongation_desc'],
	['Hardness Value (Smallest to Largest)', 'hardness_value_asc'],
	['Hardness Value (Largest to Smallest)', 'hardness_value_desc'],
	['Melting Point (Smallest to Largest)', 'melting_point_asc'],
	['Melting Point (Largest to Smallest)', 'melting_point_desc'],
	['Thermal Expansion (Smallest to Largest)', 'thermal_expansion_asc'],
	['Thermal Expansion (Largest to Smallest)', 'thermal_expansion_desc'],
	['Thermal Conductivity (Smallest to Largest)', 'thermal_conductivity_asc'],
	['Thermal Conductivity (Largest to Smallest)', 'thermal_conductivity_desc'],
	['Specific Heat (Smallest to Largest)', 'specific_heat_asc'],
	['Specific Heat (Largest to Smallest)', 'specific_heat_desc'],
	['Electrical Resistivity (Smallest to Largest)', 'electrical_resistivity_asc'],
	['Electrical Resistivity (Largest to Smallest)', 'electrical_resistivity_desc'],
	['Chemical Composition (Smallest to Largest)', 'chemical_composition_asc'],
	['Chemical Composition (Largest to Smallest)', 'chemical_composition_desc']
    ]
  end
  
  def self.options_for_sorted_by_type
    [
      ['Liquid'],
      ['Metal'],
      ['Misc'],
      ['Mixture'],
      ['Plastic'],
      ['Rubber']
    ]
  end
  
  

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end

end
