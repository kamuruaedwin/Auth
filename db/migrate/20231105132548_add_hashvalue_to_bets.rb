class AddHashvalueToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :hashvalue, :string
  end
end
