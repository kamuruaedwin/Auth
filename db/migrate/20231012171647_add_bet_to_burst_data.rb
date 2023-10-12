class AddBetToBurstData < ActiveRecord::Migration[7.1]
  def change
    add_reference :burst_data, :bet, foreign_key: true, index: true, null: true
  end
end
