class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.integer :user_id
      t.integer :weight

      t.timestamps
    end
  end
end
