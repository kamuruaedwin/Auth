class AddBetidToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :betid, :string
  end
end
