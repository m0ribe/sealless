class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :title, null: false
      t.string :pdf
      t.string :message, null: false
      t.bigint :user_id, foreign_key: true
      t.bigint :pass_id, foreign_key: true
      t.integer :type, null: false
      t.bigint :admission_id, foreign_key: true
      t.datetime :deadline, null: false
      t.integer :status, null: false
      t.timestamps
    end
  end
end
