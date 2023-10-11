class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :phone_number
      t.string :password_digest

      t.timestamps
    end
  end
end
