class CreatePasses < ActiveRecord::Migration[6.0]
  def change
    create_table :passes do |t|
      t.references :request, foreign_key: true
      t.references :first_user, foreign_key: { to_table: :users }
      t.references :second_user, foreign_key: { to_table: :users }
      t.references :third_user, foreign_key: { to_table: :users }
      t.references :final_user, foreign_key: { to_table: :users }
      t.integer :requested_user
      t.timestamps
    end
  end
end
