class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :title, null: false
      t.string :pdf
      t.string :message, null: false
      t.bigint :user_id, foreign_key: true
      t.integer :kind, null: false, default: "1"
      t.datetime :deadline, null: false
      t.integer :status, null: false, default: "1"
      t.timestamps
    end
  end
end
