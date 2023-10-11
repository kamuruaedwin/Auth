class RemoveOutcomeFromBets < ActiveRecord::Migration[7.1]
  def change
    remove_column :bets, :outcome
  end
end
