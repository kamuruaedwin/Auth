class AddBurstValueToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :burst_value, :float
  end
end
