class AddPriorityToBids < ActiveRecord::Migration[7.0]
  def change
    add_column :bids, :priority, :integer, limit: 1
  end
end
