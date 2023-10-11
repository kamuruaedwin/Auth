class CreateDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :deposits do |t|
      t.integer :amount
      t.string :phone_number

      t.timestamps
    end
  end
end
