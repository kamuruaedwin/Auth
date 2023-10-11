class AddUserIdToDeposits < ActiveRecord::Migration[7.1]
  def change
   add_reference :deposits, :user, null: false, foreign_key: true
  end
end

