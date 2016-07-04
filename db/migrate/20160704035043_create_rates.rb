class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.float :rating
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
