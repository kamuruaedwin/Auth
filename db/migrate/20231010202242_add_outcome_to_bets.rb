class AddOutcomeToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :outcome, :decimal
  end
end
