class AddCompositeIndexOnCountryCategoryChannelInBids < ActiveRecord::Migration[7.0]
  def change
    add_index :bids, [:country, :category, :channel]
  end
end
