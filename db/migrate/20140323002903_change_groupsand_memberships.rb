class ChangeGroupsandMemberships < ActiveRecord::Migration
  def change
	change_table :memberships do |t|
		t.string :comments
	end
	change_table :groups do |t|
		t.string :owner_name
	end
  end
end
