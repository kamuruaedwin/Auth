class AddLoggedInToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :logged_in, :boolean, default: false
  end
end
