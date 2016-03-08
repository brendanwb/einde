class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :brand
      t.string :name
      t.string :upc
      t.text :description
      t.decimal :units,       precision: 8, scale: 3
      t.string :measurement
      t.string :category

      t.timestamps null: false
    end

    add_index :products, :upc
    add_index :products, :name
    add_index :products, :brand
  end
end
