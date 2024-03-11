class AddProcessedToSearchResults < ActiveRecord::Migration[7.0]
  def change
    add_column :search_results, :processed, :boolean, default: false
  end
end
