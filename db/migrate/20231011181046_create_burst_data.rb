class CreateBurstData < ActiveRecord::Migration[7.1]
  def change
    create_table :burst_data do |t|
      t.float :burst_value
      t.string :hashvalue
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
