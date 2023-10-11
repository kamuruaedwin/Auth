class AddUserIdToWithdraws < ActiveRecord::Migration[7.1]
  def change   
    add_reference :withdraws, :user, null: false, foreign_key: true
  end
end

