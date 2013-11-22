class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :Age
      t.integer :Weight
      t.integer :Height
      t.string :Your
      t.integer :goal

      t.timestamps
    end
  end
end
