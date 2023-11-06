class AddSettledToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :settled, :boolean, default: false
  end
end
