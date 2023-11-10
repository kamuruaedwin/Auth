class AddAnimationIdToAnimations < ActiveRecord::Migration[7.1]
  def change
    add_column :animations, :animation_id, :string
  end
end
