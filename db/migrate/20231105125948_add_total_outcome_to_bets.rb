class AddTotalOutcomeToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :total_outcome, :float
  end
end
