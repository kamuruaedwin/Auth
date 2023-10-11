class CreateBets < ActiveRecord::Migration[7.1]
  def change
    create_table :bets do |t|
      t.string :stake_amount
      t.string :predicted_y_value

      t.timestamps
    end
  end
end
