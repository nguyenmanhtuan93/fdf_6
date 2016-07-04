class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price_tag
      t.float :rating
      t.integer :classify
      t.string :image
      t.integer :quantity
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
