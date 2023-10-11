class AddStakeAmountToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :stake_amount, :integer
  end
end
