class ChangeMaterialsAndTestfiles < ActiveRecord::Migration
    def change
	change_table :materials do |t|
		t.remove :name
		t.remove :type
		t.string :mat_name
		t.string :mat_type
  		t.index [:mat_name, :mat_type], unique: true
	end
	change_table :testfiles do |t|
		t.remove :material_id
		t.remove :group
  		t.remove :material
  		t.remove :type
		t.integer :material_id
		t.string :mat_name
		t.string :group
		t.string :mat_type
		t.index [:material_id, :mat_name, :mat_type, :group], name: 'index_for_testfiles'
	end
  end
end
