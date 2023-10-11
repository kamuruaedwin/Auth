class RemovePredictedYValueFromBets < ActiveRecord::Migration[7.1]
  def change
    remove_column :bets, :predicted_y_value

  end
end
