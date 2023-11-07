class CreateAnimations < ActiveRecord::Migration[7.1]
  def change
    create_table :animations do |t|
      t.references :user, foreign_key: true
      t.float :burst_value
      t.string :status, default: 'running' # Add other fields as needed
      t.timestamps
    end
  end
end
