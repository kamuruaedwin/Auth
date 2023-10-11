class AddPredictedYValueToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :predicted_y_value, :float
  end
end
