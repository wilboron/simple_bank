class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.float :amount

      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps null: false
    end
    add_index :transfers, :sender_id
    add_index :transfers, :recipient_id
  end
end
