class AddHashvalueToAnimations < ActiveRecord::Migration[7.1]
  def change
    add_column :animations, :hashvalue, :string
  end
end
