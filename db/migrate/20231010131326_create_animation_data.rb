class CreateAnimationData < ActiveRecord::Migration[7.1]
  def change
    create_table :animation_data do |t|
      t.string :hashvalue
      t.float :burst_value

      t.timestamps
    end
  end
end
