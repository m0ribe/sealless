class CreateAdmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :admissions do |t|
      t.references :request, foreign_key: true
      t.string :title, null: false
      t.datetime :start, null: false
      t.datetime :finish, null: false
      t.string :detail, null: false
      t.string :prace, null: false
      t.string :campany, null: false
      t.string :representative, null: false
      t.string :tell, null: false
      t.string :worker1, null: false
      t.string :worker2, null: false
      t.string :worker3, null: false
      t.string :worker4, null: false
      t.boolean :aerial
      t.boolean :firearm
      t.string :notice
      t.timestamps
    end
  end
end
