class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.string :amount

      t.references :account, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
