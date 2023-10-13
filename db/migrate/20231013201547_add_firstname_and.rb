class AddFirstnameAnd < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :middlename, :string
  end
end
