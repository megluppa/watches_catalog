class CreateWatches < ActiveRecord::Migration[7.1]
  def change
    create_table :watches do |t|
      t.string :name
      t.text :description
      t.string :category
      t.decimal :price, :precision => 8, :scale => 2
      t.string :url

      t.timestamps
    end
  end
end
