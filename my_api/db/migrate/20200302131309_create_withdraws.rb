class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.string :amount

      t.timestamps null: false
    end
  end
end
