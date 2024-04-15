class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.boolean :is_active, :default => true

      t.timestamps
    end
  end
end
