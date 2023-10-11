class RemoveStakeAmountFromBets < ActiveRecord::Migration[7.1]
  def change
    remove_column :bets, :stake_amount

  end
end
