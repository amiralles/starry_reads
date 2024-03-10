class CreateSearchResults < ActiveRecord::Migration[7.0]
  def change
    create_table :search_results do |t|
      t.string :isbn, null: false
      t.string :source, null: false
      t.text :payload, null: false

      t.timestamps
    end
  end
end
