class CreateWithdraws < ActiveRecord::Migration[7.1]
  def change
    create_table :withdraws do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
