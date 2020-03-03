class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.float :amount

      t.string :sender_id
      t.string :recipient_id

      t.references :account, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :transfers, :sender_id
    add_index :transfers, :recipient_id
  end
end
