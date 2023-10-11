class CreateLastYValues < ActiveRecord::Migration[7.1]
  def change
    create_table :last_y_values do |t|
      t.string :hashvalue
      t.float :value

      t.timestamps
    end
  end
end
