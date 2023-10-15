class AddUsernameToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :username, :string
  end
end
