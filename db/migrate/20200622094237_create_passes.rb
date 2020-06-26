class CreatePasses < ActiveRecord::Migration[6.0]
  def change
    create_table :passes do |t|
      t.references :first_user, foreign_key: { to_table: :users }
      t.integer :first_approval
      t.references :second_user, foreign_key: { to_table: :users }
      t.integer :second_approval
      t.references :third_user, foreign_key: { to_table: :users }
      t.integer :third_approval
      t.references :final_user, foreign_key: { to_table: :users }
      t.integer :final_approval
      t.timestamps
    end
  end
end
