class RenameBetIdColumnInBurstData < ActiveRecord::Migration[7.1]
  def change
    rename_column :burst_data, :bet_id, :betid
  end
end
