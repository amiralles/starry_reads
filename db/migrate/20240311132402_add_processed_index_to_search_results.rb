class AddProcessedIndexToSearchResults < ActiveRecord::Migration[7.0]
  def change
    add_index :search_results, :processed
  end
end
